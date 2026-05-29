Return-Path: <netdev+bounces-293036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHNoMj5FGWrzuAgAu9opvQ
	(envelope-from <netdev+bounces-293036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:50:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 754245FECB9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E483D303125D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47C3B27FE;
	Fri, 29 May 2026 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDnkhJ3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8953A4513
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040950; cv=none; b=hdl+Fk+6oAnzVknqoZ1rRhH3/0z9iq/OKCF4gNGaTstL4zWfL1ifQR/+XtElAdOJICntFEyVZ7uz1wOhHrMzJ7KHNVu5pCuuoeFHOW6syod+C8Je7ChPBVpS9F1jxRK8ziBP60QTt8gKAT9jj3s/3sbZ/PVTmQBy19ygJCZfXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040950; c=relaxed/simple;
	bh=05dVcR6hxwxGeoUudLUyRINe56pjnzvDHm1lNLbA2W4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iBV7QMkcQ1P9qKzfYAnfmG5MF7WL7szUU9yt4KSBQcKrqW0KbPzsA1IKFnqrkqu8Xnna3poB6ZBCBFCDPBW4ywBAaFCmx6BytlzNH4oN5GFl/+DMq84E/ihf54ZocSm68NaV2afSA08Qvl1GS0tPdVtkD8H4/tlOBZ2E9YJPXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDnkhJ3a; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45eec27f5a5so776309f8f.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780040948; x=1780645748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3qXU9Ct0hCIdQg4453GbW11DudxQMDRfVtomv6JPkc=;
        b=CDnkhJ3aZdlUCUDGGrTAqc5v9i85ON2KmZfnDyww2fs+8M4rb1gagab5YVvP8gKYit
         DvkSXRSj6fQSvjvtTUiGsvTdIU01pGzAP5YkFeaaHVet/CKkPdii8vlOjCCoNxKZlkpJ
         cM23hYagAsItfduKY2HVEcK2IgfEuxxSwEupVAUpZU6w7keDSHjH5e/vV4lY47sAM/9G
         D3rqqdGWkllOTi1Yjh4QKg0ZG8GRTGnxyoj9qt8nO/s1pcjWLE5TMTqKFyMUd62fCtmq
         aV55b4pUIN7JaxQSGyYWDrMIaNCzWmT+D7pwMR9rwk9ECLfhYgwxD8OLLzZPkEmPTF8g
         /cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780040948; x=1780645748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3qXU9Ct0hCIdQg4453GbW11DudxQMDRfVtomv6JPkc=;
        b=P9erByHHMNr1KB6fTxFSiG9HtVrOAYrm+XBBTeJuC/s9O0k4P4AnPvs0VyAiF4zlZz
         VvsYWgzgpU+GMNOLfYIe+tWebVqoOeeSzmeHrJCXecPdQ6myoAVFJ4sOqWH1u9shaFn0
         E8egyXEJvccl082cvW0aFgMZZKPHXGrT/cnImWbokD20H/YEJhJKSxCVxNY7ynn0m6gZ
         kXngeFjMrShcxnafyX3XebPG4CuZUWmZT4spbmv5PYr7eUXrsoqnc7eBIxc47OuDpDKb
         eLprAr5DyvG7VGEARdzk42DBPH7x3lLb4DgtiF04gLeyA5tru8HeQtVGtDYcCO1GqRYn
         F0Uw==
X-Forwarded-Encrypted: i=1; AFNElJ/PlsueLMNUXvw+kJQYGr/e19R/rp7cTu5dkn9DpHly7KFeugQn5zgBnPRjheaZJj2+gFeXYJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxox+CVqy/Wfa1GpCEeNRlBWqI9GFbUmsEcXSCiTdy99gk5n0O0
	y3oVPpaXkGR+fydEaoLWCFlnnBdNGlvFzDxcc3g1IoqiWvyEzcBpWsdzkRtpX5iUkzKQI6g223b
	WKkH3Umj03dxifoisKg==
X-Received: from wrtp2.prod.google.com ([2002:a5d:4e02:0:b0:43d:73dc:1920])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:fccf:0:b0:452:6aa0:1d11 with SMTP id ffacd0b85a97d-45ef146822dmr2309610f8f.19.1780040947624;
 Fri, 29 May 2026 00:49:07 -0700 (PDT)
Date: Fri, 29 May 2026 07:49:06 +0000
In-Reply-To: <20260528080441.01ab1847@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com>
 <20260525-binder-netlink-v5-1-a90e2923ebeb@google.com> <CANiq72kRC_k1cnJLmG+AUSiUH6kDXVsox3nMJnV-c6HkNXOwBA@mail.gmail.com>
 <ahbAyBD584Hk9Mst@google.com> <20260527192130.21dabf08@kernel.org>
 <ahff7OTzS46Rti5c@google.com> <20260528080441.01ab1847@kernel.org>
Message-ID: <ahlE8qZ6DjcgEfGm@google.com>
Subject: Re: [PATCH v5 1/2] rust: netlink: add raw netlink abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Carlos Llamas <cmllamas@google.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293036-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 754245FECB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 08:04:41AM -0700, Jakub Kicinski wrote:
> On Thu, 28 May 2026 06:25:48 +0000 Alice Ryhl wrote:
> > > > Netdev maintainers, what do you prefer that I put for these files? I'm
> > > > of course happy to be on the hook for this code.  
> > > 
> > > Can we put it under rust/kernel/net and rust/helpers/net ?
> > > And then add those directories to networking ?
> > > Just so that we don't have to keep wondering with every little piece 
> > > of code.  
> > 
> > Sure, will do.
> > 
> > However, it doesn't look like rust/kernel/net/ is listed under any
> > MAINTAINERS entry either.
> 
> Which is why I said:
> 
>   "And then add those directories to networking ?"

Oh I missed that. Alright, let's do that.

Alice

