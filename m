Return-Path: <netdev+bounces-298819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k9XEBOKYLGpRTgQAu9opvQ
	(envelope-from <netdev+bounces-298819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:40:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6286C67D120
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:40:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="HHb/sVbB";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298819-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31B7631506F4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81AD3D6662;
	Fri, 12 Jun 2026 23:40:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45837F724
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 23:40:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307615; cv=none; b=sA/irN8pSKeDplomEsZ/ngmDe3JJRNCX90NUSVi5a9JDETWfKncsV6EDBm7tiUbT/rE56rNoFICMkRS6ShKldSjJ4SevxKaN5GfXgpqKo9dOfO0T+5MSxYGUhUq3wGgfRAT8lzC6Y3Ygrr4meoXcJY09FFiN40unJ7S7zG7I9rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307615; c=relaxed/simple;
	bh=VyZ6rviatQkrnXQMZQAWLzXp57+Aqqzm+jnwekLdyhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA+vWhq1gOt4zQgNVzatEyen+DCIF1PrjmTArTHXgmyaUnQFFql1xFTSuIOr/aE2DJtkgjoDZJ0PoSHyhTnJjRZwTfANs64M8HSc+V/SVciw0JOpSoUIxKym1uH2tO/u4Bb5Hbf5FryKWSs2dXoAFEzFvTHz81rzRmbmx8tabeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHb/sVbB; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so1177331f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781307612; x=1781912412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itutEd4Qu44FMzbLnFizHmsxJzU6Ec6tZ5tEy1Gru2Q=;
        b=HHb/sVbBbk0rBXAOrKi23F7GidjXUZBQE6Rf4VJ9yT1KnZR4C+N4bfrVuruH0EMK1D
         wv4FyyE3IUjEQV89116zfPDof9TNXiiNKETysVi8jEvSUywlV8t2IFZQ3D7XYza1fKo3
         iPz2apQYJ5rJXwLOrIhmiUyi/0X0ks88PQy+fgyJHHX3SJD7XN1QQuAffjjiDi4s8j+y
         y0NlP8YsYmwAxfMi5In9h9bUyu3nOsou3i9p7vQUy95ZykeUcy/0okP2fS2r44ki90ic
         QEccLEN3TtH1VOMY9VfSbNEkZbFdeX74OD9xGVvd+iZ0ChSwhpM/gk9oTxbU5zHkf6EI
         P64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781307612; x=1781912412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itutEd4Qu44FMzbLnFizHmsxJzU6Ec6tZ5tEy1Gru2Q=;
        b=Qh98P5cIJGGPuJzkwUiHApWlvTaemcvMg4EkTW3MkFb7zcXZBONXnuRopqCVD+MDmc
         AOL/1jxcDcY6ow1JKikPqQFptAEYJlm4R2ZD56fjxfxb3VsxiEYrlDZxJEP2E6T9RY+R
         ysLyTeSMWcwUI1U1EJgBa/8RFqT2CMTs2TZx2QLlEHkcwqZIRKADokHteOE6j1tiox5V
         7jHt5oRpaIz9X5Dem1oveLwA8zPuTay/1dccgCaTjqyj3Bj1DCkNJWLyKWFbOyh6e0D6
         ZF2WsB3K7gNkvinYglbZVjYQruKUKG/hqOWBilyhdk1Oy+xhOvhMQP6yDwSfAzpffoDB
         uqCg==
X-Forwarded-Encrypted: i=1; AFNElJ8RbE+anb0rrcoovb1TrdmBL/1vo2yWCYOi3Lrb8FhCVf1i60eOeOiVh3AHNS2qIFt3mqMI6Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhn1YYawPSmHINzVt2LYdSufjMEXiUwDZeZbt8XtKRqj+JLd3y
	lfvIJO7fhiuO4B1NqhkH4Y+F2DClSzRlf3gVFiL/xh4PgV/P9q9v6x/E
X-Gm-Gg: Acq92OGvN/PxUXpxhCsWmNkIhrPUrjFigwYQKdUz+tClG3PLWOAnyyCTi8a40l2maIg
	yqSpTNn8T8EHbTNHvhUOL+YNVOY3wOv62J5OEE7UpTPTXWMJH9Wk6OMc84Wr0tBn2y7ataPcfSE
	TAVTiBgsTP/X0yQ+v4k8AgF0htP8wXuTVRlVF0g7T8Fx0pMqnCyWzrv3vz6X4KxwIojenzxYoAn
	cY2rUqEToJLQdvOhZMXybZ9RtmvvxyC6/IswxAnw7QkeYj/ymub5G1Pd/68N+bDNJ9x5OgO1ugF
	ZB44ZrewEy11J0lDCRoOFYDdaD3yOdGl14YGLUPogt8FipctuNRNcFcSLEy6ws7F8OKJxQENJUp
	eUx8vJtKttHd0lQen1ro89LyLsOnN9FWjx8MwfP6l1p0cTuisd8WwXQRLhYrhYTtvz9glE7M+Tj
	mZXZDiAb1fVDpzQOb+mTS5ehWVnxrevrz+Vn9pJORrB480ewsqrRR6VQzX/Jj7JvnGmAbTKExmh
	Oqa10A1bEVit2dncs8sPlrR
X-Received: by 2002:a05:6000:1868:b0:460:3210:4349 with SMTP id ffacd0b85a97d-4607ec0bfccmr1622878f8f.42.1781307612253;
        Fri, 12 Jun 2026 16:40:12 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f38df00921b0efffe889e28.dip0.t-ipconnect.de. [2003:c1:4f38:df00:921b:eff:fe88:9e28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm10142770f8f.3.2026.06.12.16.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 16:40:11 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 474C931BAADC; Sat, 13 Jun 2026 01:40:11 +0200 (CEST)
Date: Sat, 13 Jun 2026 01:40:11 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: tighten the FIN exception in tcp_sequence()
Message-ID: <aiyY24QTFcqQVW25@gandalf.schnuecks.de>
References: <20260610-tcp_fin_more_restrictive-v1-1-eefc30d7ddd8@gmail.com>
 <20260612154355.37bb426d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612154355.37bb426d@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298819-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:devnull+gmbnomis.gmail.com@kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6286C67D120

Hi Jakub,

On Fri, Jun 12, 2026 at 03:43:55PM -0700, Jakub Kicinski wrote:
> On Wed, 10 Jun 2026 00:09:24 +0200 Simon Baatz via B4 Relay wrote:
> > From: Simon Baatz <gmbnomis@gmail.com>
> > 
> > Commit 1e3bb184e941 ("tcp: re-enable acceptance of FIN packets when
> > RWIN is 0") added a special case in tcp_sequence() to mirror the FIN
> > exception in tcp_data_queue(), which accepts bare in-order FINs even
> > when the advertised window is zero. That behavior is not
> > RFC-compliant, but was introduced in commit 2bd99aef1b19 ("tcp: accept
> > bare FIN packets under memory pressure") to break tight FIN/ACK loops
> > caused by broken clients.
> > 
> > However, the condition added by commit 1e3bb184e941 ("tcp: re-enable
> > acceptance of FIN packets when RWIN is 0") is broader than required
> > and allows other non-compliant packets as well.
> > 
> > Tighten the tcp_sequence() FIN exception to only allow packets where
> > the packet is a bare in-order FIN and only the FIN flag extends beyond
> > tcp_max_receive_window(). In particular, this exception is only
> > reachable if tcp_max_receive_window() is zero. Otherwise the packet is
> > already accepted by the normal sequence check.
> > 
> > The existing packetdrill test tcp_rcv_zero_wnd_fin.pkt exercises this
> > behavior already and does not need to be changed.
> > 
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> 
> This is odd. You are sending this patch which shares a lot of
> similarities with Eric's patch:
> https://lore.kernel.org/all/20260608151452.706822-1-edumazet@google.com/
> 
> Why are you submitting your own patch instead of discussing it further
> with Eric and letting him send v2?

That's what I understood from Eric's reply to my comments.  He asked
for an alternative, so I sent this as a concrete sugggestion.

Sorry if that was not the right way to proceed.  I'm happy to
continue the discussion in Eric's thread instead and treat this as
part of that discussion.

> 
> Eric, how would you like to proceed?

-- 
Simon Baatz <gmbnomis@gmail.com>

