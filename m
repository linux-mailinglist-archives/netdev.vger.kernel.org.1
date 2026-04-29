Return-Path: <netdev+bounces-282438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ1SMmM38mk0pAEAu9opvQ
	(envelope-from <netdev+bounces-282438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:52:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A92497CDA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75A093021D0F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3577388E59;
	Wed, 29 Apr 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OetpsuxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC2301471
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481558; cv=none; b=uqQw/dynDvq+1sSwkmEywKK64eoBwaTsyaKuwvMsKixSl5fl+Lbdv2J0hRnAhXA40ofcLdWWbkO2jSXCDH4I6hdUaO9d5b3KpKAleyB4AsXAtxdfWTGjviRftEh7aV2OMAaS2r7zaiWafgv70c/E5XNHCibWjB4eIngPH2TGjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481558; c=relaxed/simple;
	bh=S6bUNLZl8nsDEfSbKOw8VZgUcPls/W6MMISxDe77f1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAnBny7R19s4SmdAcsBjiHDNnvIJZvp8xrVybDV1y9UfJ/vMswhbuv341OXQBh7ra7tkj1Kmkd17SYjhmJfvZT/z1F3KlZEapZesyJH40gn9Dg46HYYnp5zoC1YnPOCCCQtT248/mW4zVVZufOwarE23r8HWtqS9CwaYFXqo3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OetpsuxW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3591cc98871so6011747a91.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777481556; x=1778086356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8peeioOaRdZ2UtVYC342XZJGCHJrhC0RFeeWhKiG/0=;
        b=OetpsuxWxBH0otkKUsLPko9xK0j46DcbXE0z8Abe6kACf6IK1zfhWgWqp8kVCAiuqs
         FvMqrB4ccdd+Nfl5N5jZCQy8BD+grb9g2ReLGvZP+leX2KSompdmrFkBEQe6yxvQnkqD
         rY8nywNq8AbuBT3neHHLm+NHcMTOjxbdDOOD3Z6Pt0lLARGP+E9blvCUiIBZ7YFI7fOK
         7M5apTmznuE36dJARGk0PkJiX1AG/JMDuSvRmbKX5ZysW/EfhM/tw/FG6rRxHdITe0Km
         U2SBwfuTYfE8pzgkqdZfasWFAq+knGiCRQp3uuVUBa/3RpiQC9nb2tV7zuGHfFZPFJBF
         SoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777481556; x=1778086356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8peeioOaRdZ2UtVYC342XZJGCHJrhC0RFeeWhKiG/0=;
        b=RCR3TRMLftyCc7kkTUozUvuXvuQ6o76Aeg7DQRe+u9Aqqs7M6qmmGY6np5R/Q/cq67
         df1XwBqrVQjY9Cei/MpQMWQlVr3hcRQhk0N3451CmqFwazAcPf/0oAwljEnRj681lXJU
         JIW3uTrrNLX4Cymr1e2dptpaO8JXW4BxRReU+GtY9VnG5dP4UGNBgljaX9qXbXlx5/YB
         di6Culq6SNJhpLxcDOZuZU3aBoBCbLNjsOU5ZdtV4ePqoECV8yVEcmidThqp33n/fS/Z
         UnZ0Kt4vt/ghNPiXNAj/kNe3+9y1+vekZwxE9gQQ9EOZiingaOiwSesLfMEJ4ue2SSTa
         UPWQ==
X-Forwarded-Encrypted: i=1; AFNElJ80fJRhcaA4gUcQ6pGMIU6O+6VXu2hIyuO/l6dHT/Fhm0gr5xUJkFnjSi7AoqOvG5nXt5RQjjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/FRoqXiPyfxpH8pojvLaU0KIEOF3NGLoCNTBZEEfG6fD9StC
	Sd5qp9UMZHoI+SQdFDLIlbGUI/8f/zHQg+1DW8/LB0G543T1si2NG9t0qyUHArIFRFnxjU0t6Lk
	hbhk8
X-Gm-Gg: AeBDiev4s3U4m/kvd7DxdpvfdIkJnDtn1foqYlQlwDVP/10Gslpk41XWadM252H5f7I
	W8a1XxutXD7xIiAQg+JXa38+UGCv3PX3yVrVIdF5t4Yg3/e1q6S9heXRWtp+HUZO6T1hLu8EY7I
	KN6DA23jJ2JNGSYvIPbKnJR6re0A27aAyy5GPAay308yDdW7Y+3t8MlH2a1EMne4xr7sGjhgIBH
	nzfCrSRxiFvbxyLMLWh7At9UlO5QRXWecerikBXXqsCacekSKOcPGalmC+DgQpRaJSbGWrMU3z8
	Y3DzYkhgL9hXr+gRcPt+hmUaBa8K1LY3v6TXdDXNo45qFcREVCZBZ2l8/XfYvi2PiF7oDFgOrdF
	716Z6+YcfLf+gHE2IZG5/DFZIRKb89FLjV8IJmqdWjkFzqSq/TFqRPIW4a1lLKY8mBgj6LtJ3Fr
	JBagkDUQZpYARFGYKYPnK5/SKvKjVQo7C66CtuvuKTgT+s6XuiiP9yNl1yFgXLeXHhGQ==
X-Received: by 2002:a17:90b:35c4:b0:361:423d:2026 with SMTP id 98e67ed59e1d1-36491fce3b5mr10406200a91.12.1777481555639;
        Wed, 29 Apr 2026 09:52:35 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-364bdf69d61sm158848a91.12.2026.04.29.09.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:52:35 -0700 (PDT)
Date: Wed, 29 Apr 2026 09:52:29 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH] i40e: Fix i40e_debug() to use struct
 i40e_hw argument
Message-ID: <20260429165229.GF2686-mkhalfella@purestorage.com>
References: <20260428181450.2622899-1-mkhalfella@purestorage.com>
 <558971b7-caea-471a-8fe2-73ba6cc0790a@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <558971b7-caea-471a-8fe2-73ba6cc0790a@molgen.mpg.de>
X-Rspamd-Queue-Id: 66A92497CDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282438-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkhalfella@purestorage.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mpg.de:email]

On Wed 2026-04-29 13:02:00 +0200, Paul Menzel wrote:
> Dear Mohamed,
> 
> 
> Thank you for your patch.
> 
> Am 28.04.26 um 20:14 schrieb Mohamed Khalfella:
> > i40e_debug() macro takes struct i40e_hw *h as first argument. But the
> > macro body uses hw instead of h. This has been working so far because hw
> > happen to be the name of the variable in the context where the marco is
> 
> marco → ma*cr*o

Good catch. Also 'happen' should be 'happens'

> 
> > expanded. Fix the macro to use the passed argument.
> 
> I’d add a Fixes: tag, but the maintainers might have more input.

Yes, I should have added Fixes: tag. I will leave it to the maintainer
to decide if v2 is needed to fix the spelling mistakes and add Fixes
tag.

Fixes: 5dfd37c37a44 ("i40e: Split i40e_osdep.h")

> 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_debug.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h b/drivers/net/ethernet/intel/i40e/i40e_debug.h
> > index e9871dfb32bd..01fd70db9086 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_debug.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
> > @@ -42,7 +42,7 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw);
> >   #define i40e_debug(h, m, s, ...)				\
> >   do {								\
> >   	if (((m) & (h)->debug_mask))				\
> > -		dev_info(i40e_hw_to_dev(hw), s, ##__VA_ARGS__);	\
> > +		dev_info(i40e_hw_to_dev(h), s, ##__VA_ARGS__);	\
> >   } while (0)
> >   
> >   #endif /* _I40E_DEBUG_H_ */
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> PS: gemini/gemini-3.1-pro-preview embargoed it’s review until the 
> evening [1].
> 
> 
> [1]: 
> https://sashiko.dev/#/patchset/20260428181450.2622899-1-mkhalfella%40purestorage.com

