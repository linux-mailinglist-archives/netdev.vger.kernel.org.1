Return-Path: <netdev+bounces-274630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GQ2JredzmnfowYAu9opvQ
	(envelope-from <netdev+bounces-274630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:47:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130238C2A9
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DDFB300D1E9
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D63BC677;
	Thu,  2 Apr 2026 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="c9KuThKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525B3191BA
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148364; cv=none; b=MV3Ike4mxvAelX5oj2djzJ1vIIl5S9JD2PTIHUsouD+CrR9ukCAphtg4IglLSJsIL6ZfnSGZiouXFDIaDDYjjYmyiScoedT4htxkaOJ5CSZw6jYTwZI+acNoXSwYi3fG12Uow9fClR8Rnzc2zshDSA91hmQJsfqldKDQxeZuOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148364; c=relaxed/simple;
	bh=2hpKj0W2rpZV1X/Nk0YTKGlMEGHEBv4l7AGunYq/qzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2cjwRW4GYUOXnSJ4T4yJ3pgYF44yl0ZdfrPqejhV0vc748XCBx1/vFvEp+Py2xEhyCmc7uh6KK9NSTvieaZIskesfLYc9AQhncAv+gdsy4tsXrZz4vYmVB1mihvH5M63O0w4yfgT/sx+pdsKcd/ZnXSRL5VOUCbXGScHKY87+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=c9KuThKQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so427770a12.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775148355; x=1775753155; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbhezx2WOqt+8+1TPDtVgJycu5mOCitaWwg/IVagY8o=;
        b=c9KuThKQ0vrO0wR3O6YcONyNY+YNbu3QBk33RB5t3NIz/SQBmAhlgdJueikA8Wh8wu
         NoX8sOPwApukUcRqtDiTyqr9NmNSk9A2pmGZrhuA9E93VTYjJYL2/HNUjRo3JrJp1uKO
         aivSnLJ8CWC2sm6SwpqmZn18zQ5Rtv08yrV8GTHz3Zh3W61k+PjDXmNXGhXmer8qVTvc
         AmHr61v6LNXpQ2lK89a/u2HqLuYEvHjO6QmxK3wq7eC9Y4h+YTuG3GlvmAgHYmq6VQKa
         T7/KoVqtnlqnEt4nAhQJerPTXR2edKRd2eY1EaR/O/GQNa7MdyIh3SKagX2kXYEjhdKW
         uhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775148355; x=1775753155;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbhezx2WOqt+8+1TPDtVgJycu5mOCitaWwg/IVagY8o=;
        b=W/1mppB3N/ysb1lRuWfAje/Z7Ww7d9YcERGpsCdIWaB43Rua1GHqgmzqVG8ju1W0zG
         ENAZ2+aPwbor0Kxz91EErS/BNJUBcLGI8K4Z/XYH1pcIFTeWhUwrP5g4Mht+7h3UGWjw
         4VYTyOIX6UFyCSVTnx7rnJZsel1TeStLcY1UTOm0uXfyLYvxEUKiKGFUSKpKyJw/An9g
         qOn7tm2WB9XjOIVO4oVrXfT9YvJW2gAa3ohoKZ+5eaTSDDr31WFVQBHcRZM6iad8rWLQ
         bD2vpV+YEzbitpyWqulma9tD2vR8+GRixEMjz5iIN/VRpfLI3IH9dBWTSlWgVwXnTJO1
         4jog==
X-Gm-Message-State: AOJu0YzZQ8ZaVrLKY7Rgc0VUUXGIfSwx2EdAo3mxzxYyOjRFtsIl0Yv+
	EiGsGQ60ZYspxBVL+goyrR0iK5FwrV2CoGPhfN+w/UH6CGcIick4VKNtCSkaaXi8lUk=
X-Gm-Gg: ATEYQzwwgIq0PotbtamtTH73A1Zh1/X5srUCNyZdA9m+uHOlnARzOA3ib3c2mAcVzQF
	xKPpsgTYcdocXKF77UU4/RHgeywfs9l3j/cfKqjMSkFFHRKp1zK9l4NHzh10vxYQ2CZyWO/qWyJ
	ZVvbW0XGkwrYys+hKdtQSq14n1cayg7BIbYhYij2M/W7xHAspWmjVZioiegXYiAGkEeMrn1n0XI
	kzJf0q3FiVoO5UXTwyf6MeOUpAZiAdPuqvSsJBG6DmyiH3rhBT0jY542P9PMgCl+FZ9vl3p7e+O
	DgcnBJudYFSb5hZ+JvTN0FDyC3PmignNtOlluoNZdzGiiAT9odQjSMyr7XCWqVP/MMCSBDYGfwv
	LjP2x4sdxX51WyzfhoayqZ4SW4pE2+KQ7mstHZuXtnfvIwrvSuIzPG/w9N8GFP8wv69DHx++RsW
	YGX+ea
X-Received: by 2002:a05:6a21:3391:b0:39f:2c96:e0d7 with SMTP id adf61e73a8af0-39f2c96e653mr114237637.17.1775148355229;
        Thu, 02 Apr 2026 09:45:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76d2684b75sm22853a12.14.2026.04.02.09.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:45:54 -0700 (PDT)
Date: Thu, 2 Apr 2026 09:45:53 -0700
From: Joe Damato <joe@dama.to>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v7 07/10] net: bnxt: Implement software USO
Message-ID: <ac6dQa1HRrfcpBhX@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260401233745.2333858-1-joe@dama.to>
 <20260401233745.2333858-8-joe@dama.to>
 <CANn89i+dWeUvZW-sLU5ozZM5rHgDY1mXKOXM=EjdhJanumqVsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+dWeUvZW-sLU5ozZM5rHgDY1mXKOXM=EjdhJanumqVsw@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274630-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:email,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3130238C2A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 05:35:14PM -0700, Eric Dumazet wrote:
> On Wed, Apr 1, 2026 at 4:38 PM Joe Damato <joe@dama.to> wrote:
> >

[...]

> > +       /* Zero the csum fields so tso_build_hdr will propagate zeroes into
> > +        * every segment header. HW csum offload will recompute from scratch.
> > +        */
> 
> We might need a call to skb_cow_head(skb, 0) before changing ->check
> (or anything in skb->head)
> 
> Alternative would be to perform the clears after each tso_build_hdr()
> and leave skb->head untouched.

Thanks for the careful review; I appreciate your time and energy.

I'll remove the existing clears you pointed and perform the clear after each
tso_build_hdr() as you suggested with something like:

@@ -103,6 +96,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
                unsigned int offset;
                dma_addr_t dma_addr;
                struct tx_bd *txbd;
+               struct udphdr *uh;
                void *this_hdr;
                int bd_count;
                __le32 csum;
@@ -116,6 +110,17 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,

                tso_build_hdr(skb, this_hdr, &tso, seg_payload, last);

+               /* Zero stale csum fields copied from the original skb;
+                * HW offload recomputes from scratch.
+                */
+               uh = this_hdr + skb_transport_offset(skb);
+               uh->check = 0;
+               if (!tso.ipv6) {
+                       struct iphdr *iph = this_hdr + skb_network_offset(skb);
+
+                       iph->check = 0;
+               }

