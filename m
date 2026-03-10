Return-Path: <netdev+bounces-265948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDrtFzDdr2kzdAIAu9opvQ
	(envelope-from <netdev+bounces-265948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:58:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33715247C22
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58D743030A2A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AFA4301C2;
	Tue, 10 Mar 2026 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdZLP+fm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k0GFqOHH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B663F23AF
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133095; cv=none; b=jHjjf+WSWlmfbre/zykNgP6jg7R/NBB5yTOlZfQ1NBpw1M8Nc6slAetBNddnHdffpr+Yph+LR76S1niz6yZciZ6KwRHMVOD7oSTjUKZlql8W1mbP/hAiwFeZW10BXW8s18fA0N+ivUxtuvQNOJTFVQZaLvmCEE3ZoavIxUJvvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133095; c=relaxed/simple;
	bh=PQp8DMIf16n9Q4WyqamERG099p/UWm8vclqnIXpsCxk=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=EkiYj5Ni1SUJv2+mQB8F0D35JuuTlq1ZaEX9SAEYpXDFC1hVl6OXj7oF03TnFIZTfO5rkwGMNreL0Mz9BFTDVwi4Tl59NA+HdE2GvQYaZcsSHdu7AE16TC8cbcktPKq4Iz0QQRRdbv9SRLOUXCeAGl9XqMcltEqKGNZqm7BpiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdZLP+fm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k0GFqOHH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773133092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5ixMEPwXpO/+b+N1FZSIy8hHYQ/BR1nMYxWpusN4IQ=;
	b=SdZLP+fmI2XhOVd1rQJslvqAIf/lih57cvRePOQYzynQLJZHhD1MfhPDB44/7h/e96Ngxe
	TZv4CTqj6NlH4UE6ZyMgCx7Ac4iEoSwVttnrOV4d5qZaZmugHP+g8n4+uJJaB4bmunuUcg
	eW8z4DugOnHLGouSe1RccDIYlZRcV2s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-4M-fnwsoOq-pBt89x_1q3g-1; Tue, 10 Mar 2026 04:58:11 -0400
X-MC-Unique: 4M-fnwsoOq-pBt89x_1q3g-1
X-Mimecast-MFC-AGG-ID: 4M-fnwsoOq-pBt89x_1q3g_1773133090
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-485350666bfso19212205e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773133090; x=1773737890; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5ixMEPwXpO/+b+N1FZSIy8hHYQ/BR1nMYxWpusN4IQ=;
        b=k0GFqOHH/UWrRd1z09J2jblhDYQDC4igfIEdXfrgVZdYpt5G3ipiQkrqONgU+GAF2b
         77G4+gwzWQKyZv4J1QxVN4ZUfpH6eXsbXUux2dxyQmq84hyrBhMZTR/zbmpt0zjTb0IC
         nsbtR3Wbf/ce5l3oXAQSXrSEds0sdKm2UO3j+RDxRFeSQ+c6Lc6sJZROrTGT5nmNMTNx
         RMMKDmyv3QnjvnhDM1ZS4/4Aq+tw7BgqiQEh4bAM4KNFFO1u7FdIPKvpEGi+3DHakr/u
         BQtbie8gxNmo2qS7eIr1wr7rck7uOvWXjNW7QGnadLJp37fBGQ/axz2lCHDNKFjDvqv6
         wsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773133090; x=1773737890;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5ixMEPwXpO/+b+N1FZSIy8hHYQ/BR1nMYxWpusN4IQ=;
        b=cHSTsX0BfaoXeANjYIPRgIvnvNfDAZje0LrRGZiDEDN19RNOHTNzldtNA37CGt5vvj
         yXHenSvxM+E/akHMNDHbhFBtCIbF2taWFeEy+KOtISNhjQvzvdND515PUFpNI0tAXf1e
         6g0TOCypa5H0QKaBawdMbzQUPpES/mPA/saM/1PR1vlYL1uJTFusVFM0S/3IK8BFmZtk
         PZ9bAxgdVX6g37kmpMbBd6QXuLtor/uwG+ZX3rMCPkgMf1Z3V3WcZ92+dK9knZu4MW3b
         quIeEQLWCE/6jTLXvloc1+Rg1GAN17KTQNqlcrrAHl3PBTjU7YdBf6+nGvIXKRSwXNcE
         ffeA==
X-Forwarded-Encrypted: i=1; AJvYcCXpkZbo+VA1h2P6YqSIJKKKXadBn3Hx+8rtXAPf6SkY0unlOKdn7NtyMWwOM5Fcasv/QLJSkAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEmCOS5E0f7dqktC3GsCOvQCAD1BrDoNCOEtQ2c57jCM2XGgCs
	qZXrOjLkirHOpvaQDPyoD/Q8XHruMtxXgnBai0K+XTu2sNOLHn+yXrJmVQMB8SPvZdb/0rau56c
	mH/cSPWCBVBjEHxQIcKZxCYI9FDrAW3081EhajYx2jjd6gtzCSzGK075Y4w==
X-Gm-Gg: ATEYQzwK/LzLIyzFfVHbUsEMNbQG4xJNtD7AwoRAKPGkExBh0NAb4nELh3F0i0fNuiX
	VeUAZESUvyHvpiSsUAg78Ggtea0eLR8kG3xzCA0NidoG+/+oYvImiRjeLoidtPHRaY+WUQh9Eu8
	DNrrKGTHntPSRmwDLVYOiWaVQbxy7YqofcyDgoTE0PcuHY1jFg6YMTbCbDDo56N+pFhWase+5jU
	A98QLjqXOgsZrKvrFS+sqMJ8FUVxZGSlsEjwiPO3DRYXhi59+rS/rXlo5KJCN/XFqJERfznhPMH
	A2qHVXYgxR+TG/3ZIUfM43aUFonJonuqNe/W98hEJf/fSkEAT9IPo4smSMbL7RijNq5szv7KT6b
	q/Ed2T9Ot3lElKcc7razkH67g33YCK0WM4BzomJ8jMp9BnV0U6g==
X-Received: by 2002:a05:600c:4712:b0:485:41c4:e2e5 with SMTP id 5b1f17b1804b1-48541c4e453mr36599975e9.27.1773133089742;
        Tue, 10 Mar 2026 01:58:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4712:b0:485:41c4:e2e5 with SMTP id 5b1f17b1804b1-48541c4e453mr36599305e9.27.1773133089122;
        Tue, 10 Mar 2026 01:58:09 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f3cdsm67159225e9.14.2026.03.10.01.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:58:08 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Cc: gmbnomis@gmail.com, Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, David Ahern
 <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>, Jason Xing
 <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, Shuah Khan
 <shuah@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <20260310095806.121d198f@elisabeth>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
	<20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Mar 2026 09:58:07 +0100 (CET)
X-Rspamd-Queue-Id: 33715247C22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,cloudflare.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-265948-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Simon,

On Mon, 09 Mar 2026 09:02:26 +0100
Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org> wrote:

> [...]
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index f72eef31fa23cc584f2f0cefacdc35cae43aa52d..73aa2e0ccd1d7a6314a00c27950b019b62a3851c 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -316,6 +316,9 @@ struct tcp_sock {
>  					*/
>  	u32	app_limited;	/* limited until "delivered" reaches this val */
>  	u32	rcv_wnd;	/* Current receiver window		*/
> +	u32	rcv_mwnd_seq;	/* Maximum window sequence number (RFC 7323,
> +				 * section 2.4, receiver requirements)
> +				 */

I didn't follow the rest of the discussion but, at this point, what
does this mean for applications (CRIU, passt) dumping/restoring socket
data? Do they have to adapt? I couldn't find this bit of information
anywhere in v3.

-- 
Stefano


