Return-Path: <netdev+bounces-211377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE2DB186A2
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 19:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E911C2278E
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E42874FA;
	Fri,  1 Aug 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkOKBOqA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56726B95B
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069171; cv=none; b=qYPb5aBQFLwREvKGLe60PKE7GaOMO7US+4uOIU3bryVZvmVbmnqkqSVnwYMQ5YMeeGztxnn5/TEDNlzW4CLZL/toaTlgfzDdCFt5TOdFe0Gf+Q/ppauYtwFAfwiwzks58Wlfup+c9A3TNMeJ88jARutD7FZHU/1YUlDHVHwNLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069171; c=relaxed/simple;
	bh=MdNitGZXzE66cMMSZImFec816f4hFdUUzZFH+WAD/+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAdg1ajy2RA23XrfHge6sBJC9Z2dt1N1cqEDwOOkX7LyANDrPaww3zBnPCSHrKprA2Boqyq2m2c79UlA1RHmKuOoTMtb0cuzEEx4LqRlcTwUDvEwatb78b8sCtqS+64nVhan78FRnvKAyOxseWPOSOrrqH3AwEABxeHCK9UXFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IkOKBOqA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7961cf660so1033367f8f.1
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754069165; x=1754673965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6EiM/KJatc+ucR5mZfr0mKK62FA3tKj9rpi2bILnd/A=;
        b=IkOKBOqAzcPHViCAoMvLjiTvhcxKvRB+ndF6jsurHbldSn/B2XETipealQmRt0RNq6
         KxnNujv4tNFxG9o+o8htFrQmyuKIDbGwoncpWdAbWPub/MJeWvTJPnWkuRn7AKR9UVN8
         GxrnIrTKQVg0l8gvn1zkPGayG5ZmnOwS0LYF8chIUrch7wo7OngR3h4axfC7Xh9ad/j3
         sB+1qrhMONwIsqOtMZSOXgzWmnuXqK/L7eKGHdpOeLiBM9UtPWKlXjUTx4rGToA7jJsY
         vBxU+gMKjPVIfOZJwN46p/qKe3ptm/XhzdLdUasgW1cOinxr3uQths5A371DMkKEumrM
         YehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754069165; x=1754673965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EiM/KJatc+ucR5mZfr0mKK62FA3tKj9rpi2bILnd/A=;
        b=nMIfStyl9JAndk8TWu94uI+JKo+fmVvpcQB9W5iIrjU5vFGxMpPAvJNeIoiEfvg2Rq
         qnumLb2fhauA2krnog8KPR0qNZexubnTcg5sb9Uo5h2omZhbJZHY/roGSrLsmHLnNylj
         o/2I+yKGnaswgbEHPgB5JMcHnb9K2pXyxnZ2l4pznGQLHfoC2DP2SVyA0yv01JlwokBn
         1yFsFivAnVVAdeIGdic6+GpEtb+4ecWwknmEh07o0F1DiGSuHi39c6slYQK/qZ16YYgU
         kOKCBc86cIcFjcsLLv3xx5LGw9RvI0c18KDPUHvxZ9uGrhSg1G4Y4ZAA6EUf5b4SmNck
         4Tlw==
X-Forwarded-Encrypted: i=1; AJvYcCXueONAVK3QPafC4TeYrKPr8LCYQleEbgrwMkXev7yxiBc9bnVJy7JlEwANKkA+wtw2w6kH10s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbXmWBRvJOtP0ynXm2RZpYp/0hY9dA3bGxV42XBj6PvgvP7f+L
	ge32e+aSeSxX9H24+0pS9D6vOxETDOsUzTtis7CYaWTUAZmJrAAeE1VJ/diYCbyzsUE=
X-Gm-Gg: ASbGnct20YGzjXWYx8grLx3Fq1us+pY7oXyXatH4kKlBewGxgkoc7VgeAnEw/pY16Sz
	g4c/Xn5wDnbvDP0pNXd4DsmF5PnN8YKnHj6MWXaCEwFx+sk0qb/c7QkoPHxLtBpNpIOmrOfVViN
	hCoAqpH0nxA3T5EojsNHMIPBJISY7nye5Ts/jwxNtNOALK/0JvVMnpg7mD1G/PXo1vrJhk7u3XB
	rcDfgCL7dJbZd26nHYuks3rcpiOazUWIY9dB/KVQlfHmMn85kO1Fwh2+MRD2i2ITYNRtKJsoFz8
	Ot5eIIO5oP3WoVNHx7gB0ZQ5FwCX8Puz5O77Ka2YY5EU29c9SgCxKf08BH5RyMLx7wzy850ZT0F
	F5GVHarXhmQKRGavDrGfLQtoPSRo=
X-Google-Smtp-Source: AGHT+IHAUeFa6/L6+DPVdGCHqTHNZKP+82EyvT7TFvOoB5/jAHJVvAhOUppBpUCtdqpOWh869tT/Sw==
X-Received: by 2002:a05:6000:2383:b0:3b7:810f:6caf with SMTP id ffacd0b85a97d-3b8d94bc74bmr495619f8f.32.1754069164946;
        Fri, 01 Aug 2025 10:26:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4589edf55e4sm72892475e9.2.2025.08.01.10.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:26:04 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:25:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Mihai Moldovan <ionic@ionic.de>, linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Denis Kenzior <denkenz@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 04/11] net: qrtr: support identical node ids
Message-ID: <aIz4pj5qgXSNg8mt@stanley.mountain>
References: <cover.1753312999.git.ionic@ionic.de>
 <8fc53fad3065a9860e3f44cf8853494dd6eb6b47.1753312999.git.ionic@ionic.de>
 <20250724130836.GL1150792@horms.kernel.org>
 <a42d70aa-76b8-4034-9695-2e639e6471a2@ionic.de>
 <20250727144014.GX1367887@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r8QhGFlBadusXMk7"
Content-Disposition: inline
In-Reply-To: <20250727144014.GX1367887@horms.kernel.org>


--r8QhGFlBadusXMk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 27, 2025 at 03:40:14PM +0100, Simon Horman wrote:
> + Dan Carpenter
> 
> On Sun, Jul 27, 2025 at 03:09:38PM +0200, Mihai Moldovan wrote:
> > * On 7/24/25 15:08, Simon Horman wrote:
> > > [...]
> > 
> > Thank you for the reviews, to both you and Jakub.
> > 
> > 
> > > This will leak holding qrtr_nodes_lock.
> > 
> > It certainly does, will be fixed in v4.
> > 
> > 
> > > Flagged by Smatch.
> > 
> > I haven't used smatch before, and probably should do so going forward.
> > 
> > Curiously, a simple kchecker net/qrtr/ run did not warn about the locking
> > issue (albeit it being obvious in the patch), while it did warn about the
> > second issue with ret. Am I missing something?
> 
> TL;DR: No, I seem to have been able to reproduce what you see.
> 
> I ran Smatch, compiled from a recent Git commit, like this:
> 
> kchecker net/qrtr/af_qrtr.o
> 
> The warnings I saw (new to this patch) are:
> 
> net/qrtr/af_qrtr.c:498 qrtr_node_assign() warn: inconsistent returns 'global &qrtr_nodes_lock'.
>   Locked on  : 484
>   Unlocked on: 498
> net/qrtr/af_qrtr.c:613 qrtr_endpoint_post() warn: missing error code 'ret'
> 
> That was with Smatch compiled from Git [1]
> commit e1d933013098 ("return_efault: don't rely on the cross function DB")
> 
> I tried again with the latest head,
> commit 2fb2b9093c5d ("sleep_info: The synchronize_srcu() sleeps").
> And in that case I no longer see the 1st warning, about locking.
> I think this is what you saw too.
> 
> This seems to a regression in Smatch wrt this particular case for this
> code. I bisected Smatch and it looks like it was introduced in commit
> d0367cd8a993 ("ranges: use absolute instead implied for possibly_true/false")
> 
> I CCed Dan in case he wants to dig into this.

The code looks like this:

	spin_lock_irqsave(&qrtr_nodes_lock, flags);

        if (node->ep->id > QRTR_INDEX_HALF_UNSIGNED_MAX ||
            nid > QRTR_INDEX_HALF_UNSIGNED_MAX)
                return -EINVAL;

The problem is that QRTR_INDEX_HALF_UNSIGNED_MAX is U32_MAX and
node->ep->id and nid are both u32 type.  The return statement is dead
code and I deliberately silenced warnings on impossible paths.

The following patch will enable the warning again and I'll test it tonight
to see what happens.  If it's not too painful then I'll delete it
properly, but if it's generates a bunch of false positives then, in the
end, I'm not overly stressed about bugs in dead code.

regards,
dan carpenter


--r8QhGFlBadusXMk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

diff --git a/check_inconsistent_locking.c b/check_inconsistent_locking.c
index f3cce559d7a6..e95d9110a1e1 100644
--- a/check_inconsistent_locking.c
+++ b/check_inconsistent_locking.c
@@ -67,8 +67,8 @@ static void check_lock_bool(const char *name, struct symbol *sym)
 	FOR_EACH_PTR(get_all_return_strees(), stree) {
 		orig = __swap_cur_stree(stree);
 
-		if (is_impossible_path())
-			goto swap_stree;
+//		if (is_impossible_path())
+//			goto swap_stree;
 
 		return_sm = get_sm_state(RETURN_ID, "return_ranges", NULL);
 		if (!return_sm)
@@ -145,8 +145,8 @@ static void check_lock(const char *name, struct symbol *sym)
 	FOR_EACH_PTR(get_all_return_strees(), stree) {
 		orig = __swap_cur_stree(stree);
 
-		if (is_impossible_path())
-			goto swap_stree;
+//		if (is_impossible_path())
+//			goto swap_stree;
 
 		return_sm = get_sm_state(RETURN_ID, "return_ranges", NULL);
 		if (!return_sm)

--r8QhGFlBadusXMk7--

