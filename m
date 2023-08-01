Return-Path: <netdev+bounces-23463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A0176C072
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189461C21129
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297AA235B5;
	Tue,  1 Aug 2023 22:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F627729
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:31:13 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E28E4E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:31:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f090316dso4219855b3a.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690929072; x=1691533872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5rI769blANvKakho//KZylc2H6HwF2kf18muyWtGVFE=;
        b=S/mRkmfA0lmJMoq6lyuKbHLryPTrbrj6nCOzzsunS253TyR6O8d01K9JabxWlHKwgU
         XQjqXimg+lQVrOaG3Ag0dTf5G4KwNryKCHUVHRQ70ZwVX3MsWtmwU8WO8JJW3pERGdWr
         FFD/J8g17ysNh5AGszxYdGXbK8sSCpprcMm5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690929072; x=1691533872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rI769blANvKakho//KZylc2H6HwF2kf18muyWtGVFE=;
        b=OVunPdbNhSy6SYyueSFiYezkD8eRs3bST0rWodqzw9aUL7u0SDK1sKAvOq1tXn1+6F
         JxQJ56SdE7nCTKdYOj8v/FnfMl6KUaPk3yxA1JfRr6TdajmAJtaGHNZVv3YpmUaY4tWc
         wI3sWBE6+3W7HfWU5RWFBL3vUdz2S0ZCtJNzkROzvF/d1mhnxu8k1RxYMwbRyvMixenh
         vIcU3+HgPJM/xcP6609/6oraadJp7jHt8th/IMt5W3DNelXaC3EiodSyMmL+2rijahBN
         Rn9R+x5Ki6+qXHc6daU/MP5z1qQNDWOv1FNsS8bcFiapqO0Fhd2g02n6A5zkZcroypmL
         +eag==
X-Gm-Message-State: ABy/qLb1bkZiPGQjl1xJlyNzl5Wq5VNSlYoeFKdIq4h/g7maskheFIeu
	MqD545pAdowyhSzOvza80SqESw==
X-Google-Smtp-Source: APBJJlEB8hJ/wfGV5TLpVSHRxwHvYwuuNQs9GxuXEQyZQxV8JwciDeGgwsHIx2ioq2H59TUVG6owXA==
X-Received: by 2002:a17:902:f547:b0:1b8:b827:aa8e with SMTP id h7-20020a170902f54700b001b8b827aa8emr14471846plf.11.1690929071987;
        Tue, 01 Aug 2023 15:31:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a17429sm10957681plb.280.2023.08.01.15.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 15:31:11 -0700 (PDT)
Date: Tue, 1 Aug 2023 15:31:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [RFC net-next 1/2] overflow: add DECLARE_FLEX() for on-stack
 allocs
Message-ID: <202308011403.E0A8D25CE@keescook>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
 <20230801111923.118268-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801111923.118268-2-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 01:19:22PM +0200, Przemek Kitszel wrote:
> Add DECLARE_FLEX() macro for on-stack allocations of structs with
> flexible array member.

I like this idea!

One terminology nit: I think this should be called "DEFINE_...", since
it's a specific instantiation. Other macros in the kernel seem to confuse
this a lot, though. Yay naming.

> Using underlying array for on-stack storage lets us to declare known
> on compile-time structures without kzalloc().

Hmpf, this appears to immediately trip over any (future) use of
__counted_by()[1] for these (since the counted-by member would be
initialized to zero), but I think I have a solution. (See below.)

> 
> Actual usage for ice driver is in next patch of the series.
> 
> Note that "struct" kw and "*" char is moved to the caller, to both:
> have shorter macro name, and have more natural type specification
> in the driver code (IOW not hiding an actual type of var).
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  include/linux/overflow.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index f9b60313eaea..403b7ec120a2 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -309,4 +309,18 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  #define struct_size_t(type, member, count)					\
>  	struct_size((type *)NULL, member, count)
>  
> +/**
> + * DECLARE_FLEX() - Declare an on-stack instance of structure with trailing
> + * flexible array.
> + * @type: Pointer to structure type, including "struct" keyword and "*" char.
> + * @name: Name for a (pointer) variable to create.
> + * @member: Name of the array member.
> + * @count: Number of elements in the array; must be compile-time const.
> + *
> + * Declare an instance of structure *@type with trailing flexible array.
> + */
> +#define DECLARE_FLEX(type, name, member, count)					\
> +	u8 name##_buf[struct_size((type)NULL, member, count)] __aligned(8) = {};\
> +	type name = (type)&name##_buf
> +
>  #endif /* __LINUX_OVERFLOW_H */

I was disappointed to discover that only global (static) initializers
would work for a flex array member. :(

i.e. this works:

struct foo {
    unsigned long flags;
    unsigned char count;
    int array[] __counted_by(count);
};

struct foo global = {
    .count = 1,
    .array = { 0 },
};

But I can't do that on the stack. :P So, yes, it seems like the u8 array
trick is needed.

It looks like Alexander already suggested this, and I agree, instead of
__aligned(8), please use "__aligned(_Alignof(type))".

As for "*" or not, I would tend to agree that always requiring "*" when
using the macro seems redundant.

Initially I was struggling to make __counted_by work, but it seems we can
use an initializer for that member, as long as we don't touch the flexible
array member in the initializer. So we just need to add the counted-by
member to the macro, and use a union to do the initialization. And if
we take the address of the union (and not the struct within it), the
compiler will see the correct object size with __builtin_object_size:

#define DEFINE_FLEX(type, name, flex, counter, count) \
    union { \
        u8   bytes[struct_size_t(type, flex, count)]; \
        type obj; \
    } name##_u __aligned(_Alignof(type)) = { .obj.counter = count }; \
    /* take address of whole union to get the correct __builtin_object_size */ \
    type *name = (type *)&name##_u

i.e. __builtin_object_size(name, 1) (as used by FORTIFY_SOURCE, etc)
works correctly here, but breaks (sees a zero-sized flex array member)
if this macro ends with:

    type *name = &name##_u.obj


-Kees

[1] https://git.kernel.org/linus/dd06e72e68bcb4070ef211be100d2896e236c8fb

-- 
Kees Cook

