Return-Path: <netdev+bounces-297780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nLPyOReaKWr7aQMAu9opvQ
	(envelope-from <netdev+bounces-297780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:08:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF866BDEC
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:08:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="d pEusdM";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=a6NqPMil;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297780-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297780-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECC7E3028C0C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5734752A;
	Wed, 10 Jun 2026 17:08:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE59339847
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:08:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111306; cv=none; b=dDnFrBz1QaAY3UNSrTzLzP/VdEsCIsVWAU8Qqh5qo/XghB116KMamybYxuCaYn3AHh5gXgjp6AQQPuer+DdRe9qPsraQAsQvt0+hKhXEH5NtGhiXBqWV2XQ6t/NKsO02lxth2iVUxErBbgLhUA6NyGnP8bEmz2GjBizP6DdRKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111306; c=relaxed/simple;
	bh=Z9o5VHivGPQw3Zb+Uud7Mh4XaaNsv4zVxVEKa3aujbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZqa2cF2/1MFHOU3iZxIc/MpaSItdn6fj79ySd0b9gQEolyQIRiz5kIll3TJn+w1pFpDdzy8YeDc5WRHoVvbSQ1pqNpUP96uHn8maiXNaP68U+S2ZfRx1SUyctXYI82Sb//kIpK3V9CXt3hmwvzIyZmC/zLiAiiS/RCxsbCpdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dpEusdMd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a6NqPMil; arc=none smtp.client-ip=103.168.172.159
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D81514000B8;
	Wed, 10 Jun 2026 13:08:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 13:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781111301; x=
	1781197701; bh=rA10K18g8lvrr54zYEVktKo/B6ocGbXzahaFWPeYY4o=; b=d
	pEusdMdUX9CCiG4GqHeR+paadjlqBb04XwdfQXDHus8K4YmY1LNjprG5gEI2EVyK
	9QnHrS5JikeqKHE6WLuaipkGS987RjHSmZ5NDIgu4dql4Tl6SK1KjuUWRbd93Uka
	M9AOzmWf0zJfqzHCA0HwgEkBi3NTmjnKxzKckpSRewRHi8BKj5TU8KKyonp0HuiQ
	8nX9FMWao1BOX/rmcm72GzCWcGPssYBle1Ue6QWuavkI75JaLVYV49K6MdgUvHhD
	GUFX+Vprb8G+M1W9C1rgdUAiXw32wg0XuzsoFSIXMB3uGVMUXSbueY31FjA/NZRC
	QBP4/edDju4mXIrPoT8Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781111301; x=1781197701; bh=rA10K18g8lvrr54zYEVktKo/B6ocGbXzaha
	FWPeYY4o=; b=a6NqPMil28RbqvGEgceV0vOeUrEwzuvNxjFFI6XBeErlXbjBvl0
	diayotHa7/WjrCdflVXFqCcuZLZeP9EvJ9Ezw69BogKL8fEaihYgsNCatronlu3J
	dY8cJIKJuZ4Cnk7geE91vLYOIWqOuxlgrxCC1EKT1twBguTjZmaRncjXiz8afZnt
	Vaps70EbTCE2GM5nFPRX+++fs1W9uVuDZ770JuAbAaIoknQS6jLubUyuQXW5PgVE
	iasLDFZbkfW47dhObAB7kLfGJH8U9aGGJNH/fqra5cicNyN7CaApVjkicuDw5FtM
	BWcokx30d/WyVtSKqI2OiH0H7qvsym3P5VA==
X-ME-Sender: <xms:BJopap9lhQURpOhrWMSnXQGiDsImhrI2JEbBg8VFZVbJvt_Eq4dUjw>
    <xme:BJopagT_YPZyN8Mn7Nn_AQ1jWkSidJwBxV4HIj_rUr2WNlmsH5KE2YB6CD7KVxvU7
    gM4DE20CNlkhfYCWyFTNuDmKBE1E5R6KRUupMPG-RUOnoqm4cJGZMc>
X-ME-Received: <xmr:BJopaqoBOCNPsgLS2mDF72LEJlNBMPVieQ_HYerkh193pVjze2WYsFlAIduF_VRQxKKFejt7GOY3yubbq6T7MUA>
X-ME-Proxy-Cause: dmFkZTFj7Tzr/wGsVqDEdnWgu4FaizFXXXwmbD7ULBOZ68qqr+40Kc9mh9jdUla9v+pzXq
    2gCwBETBGzGR2bmUaHg/qzPfgRIeDFm9NxUYVLZHveaTVXuGilDu5AM3iQrikViZSfZvgz
    T6D+HnhEZH0kTkZrPb/N7+srZMgbuvy/E/Lorxv6tmioAK/kBM45Qbs5g9hm+UcVekPYYk
    1TMJ6d79nFM/Tw+WKXAp902jBnLlr6knbp3Ub4abugxqsOxmIDU7mRySa3MTr57XPh3Cio
    7DjAv6e+w92JZ6r+Tg2Nta5GWEoFASALLbYmCkxPDYAxMw02WuHF1V3h9uS7LWrZFT+oDP
    ZwW7PMtGfx/KgsuhyJ3nVtNqFQ+HAr3WIRU/M9k6+4R1K37CIjjyoffpVkgxbs6YO3Xcjb
    YduECiaq5eFL5x2ES4dkYuUI/xT25xR/Gc/+Pp7JiEFBKpEVDDXJg7qVEEg0X8jGRJuDCS
    tUA/8vdH4x9sTEV7sw3aoQmoepR9tZlav/DT7S3aOPg65FEG9Dvqp36xm0uqoT6vkWTL5f
    hKxJeJks7EBlDj0EcJlIYSqT7xdUq0DHS+ySc7Cc5Re1Azq1Ghg2b2xB4dw840HHQU95eN
    emkGkKH2/ow36MNtM4E3uwvxOGMvmoDtSLUhs4jX+8fp3Mx1JjCQ0qM0ZzcQ
X-ME-Proxy: <xmx:BJopatkmnFLxq-RbZg9Zjk4_nlXHm0diIpJvez5mjNl6hbj-BQoMlA>
    <xmx:BJopajew7_aF7io-go0qGZuTXvVeDBrBsd6CXevYTtQbQSRHm0LKTA>
    <xmx:BJopapontbKuqOPoqQcbQ9noxF0moEeRJl32Qcx9erdUcmlMgi01kw>
    <xmx:BJopatM0ta8nENNS450-Ta-PZZykcyy1H70zQ8jWZ0ICcnlUnOR5yQ>
    <xmx:BZopakUFeheBxVbPoGp2O1wKB-uB_ZSFFUHlij98j3GulHnbsRNJck9j>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 13:08:20 -0400 (EDT)
Date: Wed, 10 Jun 2026 19:08:18 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Ayush Sawal <ayush.sawal@chelsio.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: remove tls_toe
Message-ID: <aimaArGsuD6Evobp@krikkit>
References: <cover.1781013810.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1781013810.git.sd@queasysnail.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297780-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:ayush.sawal@chelsio.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[chelsio.com,gmail.com,kernel.org,davemloft.net,lunn.ch,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11FF866BDEC

2026-06-09, 16:21:20 +0200, Sabrina Dubroca wrote:
> This series removes the tls_toe feature, its single user (chtls), and
> cleans up the EXPORT_SYMBOL()s that no other module requires.
> 
> Tested only via make allmodconfig + make.
> 
> Sabrina Dubroca (2):
>   tls: remove tls_toe and the related driver
>   net: remove some unused EXPORT_SYMBOL()s
> 
>  Documentation/networking/tls-offload.rst      |    6 -

I'll send a v2 to fix the docs brainfart.

Sashiko is suggesting a few additional cleanups:

 - remove NETIF_F_HW_TLS_RECORD/_BIT
     makes sense, I'll add that too

 - do some more cleanups in the cxgb4 driver (CXGB4_ULD_TLS is now
   unused, but then if I remove that I should probably remove some
   other things)
     I'd prefer not to mess more with the driver, as I don't know
     the code and I don't have the HW to test any changes.

-- 
Sabrina

