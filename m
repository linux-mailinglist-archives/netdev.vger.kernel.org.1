Return-Path: <netdev+bounces-231878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD6BFE1BF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE7218C7A91
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3AE2ED16B;
	Wed, 22 Oct 2025 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gGfatq2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A037317C21C
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163232; cv=none; b=m4oReOjqw4SZCMDCfiTygDumgYWYHSeDFhVtz97gn19P49jaXuApCxPnZ1zJXz0sBmgzE8zUpVBZYWJGUx09g5YiybuSsQwIKV8EinR3pE9uOL8SGT8hQSjq2Vni29ixkNZoHGMhzHoY/PClW6gN2dQD3KcQZlIknq/1+VuqueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163232; c=relaxed/simple;
	bh=a/TO7CArBPgsXA2SkPZxAuzoBeZFYJy1D6O+BgTqfpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJCXqfZKjXrh3/Op3/bCckyq4+cFa3NuMso7Witg2tLhZl2nvoV3628Pmxmew8fS7axWbBvkPDOAo+zgpcPn9OnOHn1aIRlKGyMaeP5oIfXDg8x/3LBCAO5vr8AZgEV1NA34DSKpTsAHHTa+J0HQlUhGN1z3Mu9W6fFItcX2DQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gGfatq2u; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d3effe106so12496266b.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761163229; x=1761768029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pAixEBWIaP2ajOjwkWAyMaX4zgj45ebpxp49p5AfmE=;
        b=gGfatq2u3Cts1UAceqQu7Ke5lh/KCK1LRg2Gto8ochrYPBZlsCdLkZQXNdxsUFTfV4
         6OdfDBRxBgCxEQ+ySAbfnGCsQbTWCCmHOLBrYnTr+K/YYqX9oMtUnnu++UBAe6zFjMkh
         2H41lMyklYWsFccbolCFNPPI7SdNoE3CMbugP0K1Mn4P3ySxcI6aTwUnrr7lYLxLNxH7
         iKqPqrwXFeuQT8O7spBkl+PzZZA5b1Rsaat0NDlU0qYtVuC60+jBB0qERktU9/6au9rC
         BVql/2MW0g0Q3z5oyysV1no5xfCd6/sI/q0XvdEOUpTSbrX9PYIBKMsCAid0QwiaWMgm
         J3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163229; x=1761768029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pAixEBWIaP2ajOjwkWAyMaX4zgj45ebpxp49p5AfmE=;
        b=D0ipUTyv9NygAhj8pbxOda2W8fzkZC/+/RqsC/uLncAmEx6sR3E3H+zPjOOopyYcoB
         iH6zd/jhd7Kotg2Sk2PXCdVEV+mFOzHqE++9fvqtS/onxMP+P9a/g0Q9XOzzSno3f3lJ
         oIxLeJivYl41uOu5cLwgRYd+DCGwf7LiRhL1kAxmIbRGnOmcntelJ0+4t24o/qE5lKvp
         t5f3r/XfpQRtPnzP1qIIrbMh+Ud03FVNIIrIyaYxTjaxcbZmwWZw7xrDzG1qQExSquRi
         ILPOBecWgyMTPIJR1dN5q1uQ/qQR67TvR7C1gyV5+b9j7YFb2JoXrwLNDSqfjYSv0xf5
         9euA==
X-Forwarded-Encrypted: i=1; AJvYcCUHKjAJXBG38lqku7sjJkbTIxSh902IYe0HR3EYtfyfVv3AETLnq56NtVoStDpmo9P9padDMM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3FLE1Kp4tTeU5ejoO2OIPTlT567tr0D41RzePwpAgDOb9+K65
	lyjcuqrrbz6LXYgOa503HMBHanCMvybS0CgK6hop8LTCkgqQ1HBl7vtF
X-Gm-Gg: ASbGncuR98mdxBjOknsyRCDpxYn4MkcEA90YoPL8ilBjS9dECPOnhY3hPX6apFEIry3
	C8qFiGyuhjRlcfZPF+PUrTY8kC7Tq0zrN5XMFeA4LFq4LZLDfMxFcK18aIwe4FHqE5x568WwGnO
	xR3I6HShPjYXM7K5yBScyzcGEdbIz+bOIdR1SAyWpJ+wAN4NtC23uozFNrxUEMB9UG9QhL1djth
	ZTELilGf4C/5dUbqI3D8U2gU4BOXxjCYa/ziPXf8f3za1Ly9IgphfI33nIxMht3DXhXUYNXXY4L
	2AWGsB8PLqbTwIlUmErgiMutBJUlDYz2le+rKz4H79OJ4AvfK3xxg6jyNX3b8PSkLLEBLUBzOmY
	fWqxN1q3A9F3h5VZZD6dWsmGCfPM9MOfvgiTvA9RRtjH0vWcrcAeh8AJz85CMvwsZ9iW39U9H
X-Google-Smtp-Source: AGHT+IGDlatsurB3Wc3a3fbImO1VIVKH+VUWrV+FUI2+NJy2RNl4l5hvEvrMptqlXr9Ol2yfoZpz/Q==
X-Received: by 2002:a17:906:9c84:b0:b3e:1400:6cab with SMTP id a640c23a62f3a-b647314956cmr2685027566b.17.1761163228710;
        Wed, 22 Oct 2025 13:00:28 -0700 (PDT)
Received: from hp-kozhuh ([2a01:5a8:304:48d5::100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d51472610sm585166b.79.2025.10.22.13.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:00:28 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Wed, 22 Oct 2025 22:59:20 +0300
From: Zahari Doychev <zahari.doychev@linux.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net, 
	matttbe@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH 2/4] tools: ynl: zero-initialize struct ynl_sock memory
Message-ID: <almqzjbidly6hm2j4qcbqdu4cvw7td5oinvj24od3e5vrfnfmz@delkgaxlb4jy>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-3-zahari.doychev@linux.com>
 <20251020161639.7b1734c6@kernel.org>
 <7mgcwqzafkqheqmbvkdx6bfeugfkuqrgik6ipdoxy3rtvinkqq@uxwnz7243zec>
 <20251021162209.73215f57@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021162209.73215f57@kernel.org>

On Tue, Oct 21, 2025 at 04:22:09PM -0700, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 20:36:38 +0300 Zahari Doychev wrote:
> > On Mon, Oct 20, 2025 at 04:16:39PM -0700, Jakub Kicinski wrote:
> > > On Sat, 18 Oct 2025 17:17:35 +0200 Zahari Doychev wrote:  
> > > > The memory belonging to tx_buf and rx_buf in ynl_sock is not
> > > > initialized after allocation. This commit ensures the entire
> > > > allocated memory is set to zero.
> > > > 
> > > > When asan is enabled, uninitialized bytes may contain poison values.
> > > > This can cause failures e.g. when doing ynl_attr_put_str then poisoned
> > > > bytes appear after the null terminator. As a result, tc filter addition
> > > > may fail.  
> > > 
> > > We add strings with the null-terminating char, AFAICT.
> > > Do you mean that the poison value appears in the padding?
> > >   
> > 
> > Yes, correct. The function nla_strcmp(...) does not match in this case as
> > the poison value appears in the padding after the null byte.
> > 
> > > > Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
> > > > ---
> > > >  tools/net/ynl/lib/ynl.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> > > > index 2bcd781111d7..16a4815d6a49 100644
> > > > --- a/tools/net/ynl/lib/ynl.c
> > > > +++ b/tools/net/ynl/lib/ynl.c
> > > > @@ -744,7 +744,7 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
> > > >  	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
> > > >  	if (!ys)
> > > >  		return NULL;
> > > > -	memset(ys, 0, sizeof(*ys));
> > > > +	memset(ys, 0, sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);  
> > > 
> > > This is just clearing the buffer initially, it can be used for multiple
> > > requests. This change is no good as is.  
> > 
> > I see. Should then the ynl_attr_put_str be changed to zero the padding
> > bytes or it is better to make sure the buffers are cleared for each
> > request?
> 
> Eek, I think the bug is in how ynl_attr_put_str() computes len.
> len is attr len, it should not include padding.
> At the same time we should probably zero-terminate the strings
> in case kernel wants NLA_NUL_STRING.
> 
> Just for illustration -- I think we should do something like 
> the following, please turn this into a real patch if it makes sense:
> 
> diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
> index 29481989ea76..515c6d12f68a 100644
> --- a/tools/net/ynl/lib/ynl-priv.h
> +++ b/tools/net/ynl/lib/ynl-priv.h
> @@ -314,14 +314,14 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
>         size_t len;
>  
>         len = strlen(str);
> -       if (__ynl_attr_put_overflow(nlh, len))
> +       if (__ynl_attr_put_overflow(nlh, len + 1))
>                 return;
>  
>         attr = (struct nlattr *)ynl_nlmsg_end_addr(nlh);
>         attr->nla_type = attr_type;
>  
>         strcpy((char *)ynl_attr_data(attr), str);
> -       attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
> +       attr->nla_len = NLA_HDRLEN + len + 1;
>  
>         nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
>

thanks, we take a look at it.

