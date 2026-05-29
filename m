Return-Path: <netdev+bounces-293222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN5AKUnvGWoW0AgAu9opvQ
	(envelope-from <netdev+bounces-293222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:55:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0830F6081CD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD00A3017011
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF33A9D8B;
	Fri, 29 May 2026 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ4wuKwh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24199348C75
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084550; cv=none; b=KFbdXqgvxin4OxFZRNUAAYjuHIHmV5VDcaqIIiJsjD1837GSU1z1KWCzMxR9I1SBhPiaW/TVNdFtp+HCCTLPY9Oc/DfzGioO4Wfn8b8RgZv6/RYbYbbhrmHlbySHH2hfBp2sRIp0fOHMViaKf6FIMrjpvocxRAuVhoHEZpRRFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084550; c=relaxed/simple;
	bh=nVgE9qlBpH6Vpug6+AXollE2Ad/sAwmeWy15uZv6Lbo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o2fAVMCg5paH+qskzYaJjQat518XgEb9FsaL4vGuqxncY7eDiP96ONNl3Xrqvube1nImD9GxsIc+SSX094xDp8Ao/XVTDlJ4fgM+t1n96j38sE6pmhggkYmBQYZ0dKpZA/xbIYzkYws3qya0HsfL+w61Mk46mpBPXe7pBoMi0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ4wuKwh; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bf0b47d2f1so128631827b3.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780084546; x=1780689346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++bl2TsIkARQcOFrLLhx5HAHFalwO+LIjS6Jh6WdbYo=;
        b=kZ4wuKwhJKtqUrrYmfiZJOwNIiGZfeEEDLgIZTM8UCfd5hMTu4SeWqfU0Q8WGIR95M
         r/rGIWwjNE1HTkseNoQT6fyAnlXD302ztN21z5B3xns3oY/7ANEFZghMSRFxyLj50V3I
         2w0dXPJkBqV1/q4Iyc0waR4BIwtwV5DkBmAY2SKfu1ZP3tPESvN5fNgnicuEPPEm4ox9
         LTkW7Nictvq7ue5xLw4JnN4C1kWiaUKSTspuGPRO9mphRUX2bdLFaBN/kcfMZIE6nAlC
         UInhcWMMeJ0277QNVAwYe58EbEHzxueSyfYoNm7UtfeZxj6JHvHDExSlwQj+HbQZgcfw
         pgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084546; x=1780689346;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++bl2TsIkARQcOFrLLhx5HAHFalwO+LIjS6Jh6WdbYo=;
        b=lBPwi4FwyvVkeIMugdP/zJJMvEWhlfeQitZBmRALGbjHsbQopoHWj21+Z50v1yEIdC
         4d0ESpI7HDQ9mcBLrZfZWx0uXOagOsKCWJgNAYOHh2yewJQf9+r55ju0cEorwXCjDkvD
         YMIh31o+sA3JYtVQoSp+QOV+rh7AhlVIScT8TTh4wsBuDv2mb6RZaJH7bZoCuUaFpil9
         VqmPj8mDBYqv+iJSO/6+3ACeiXIYQ36arIM99ZefVGX7e5NMcxl6FXsQXz3QcQuDRAXF
         CXIbr9YRSxLxWqewHUEMJ/FsXmiqKLmTdBg6pg+Bhd/U9oADc4iXZYWdqzY72xDw++g/
         1pBA==
X-Forwarded-Encrypted: i=1; AFNElJ+NeNSYYVFe44y+o46mXHF1YGD4QvEBjlSl68U8UkP9WDC9Dagy6xypyslCQyaZAPyJCznEbJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ36Y0WgSRjqBq8/F5+qyC9t+adrLNhSoUsgMQu1RfGHCFMNrX
	NgMo/6DB+43kzBGd4SJNjOcDERAduNHByT6XqK5XKm494cbAra6YOg0B
X-Gm-Gg: Acq92OEYn0ZTHZDIqu8YrFl+sGHtN/JmlQRlTZYCHEWFTgwofsUzdc4sfhxxym817bd
	sDiGnzsxrgZ10Y8Jz24C4PfMzsYb6qdA35mw7UjXpgEsHmE75yo8VEsObmD1lwZs2aTHxW41M3M
	/o8hd3nKOzaORMYWLUjfgtvYe+5lskGihQnlDEAZ7RugEDe+dvHh/xYN0Zo0gzQXL9p7oOvQKDR
	lymxjA3cJYRSjFQIxVK4heCEonp8b9Q9/XqKROC2v1cF2Gp7EDQgoWDxfx0b6YzPiceXglXjBPR
	Zp+dyYt8ZPojmO2YdI92NCZfcBEjaK+hdFfO+5Qs99v0sGZLiQ30H97DSUQfBCRoU/LjyWX7Ogm
	rf0zwGGW8P79vrqA4W4TuXROhQuMbT0E3YRsmkcbvj5C4owZ5i2Jumr+OBklremF2TXzYmYzOr6
	cwFN2QqxZ00EcyRRpPmwUDNi5sv4Cl1IZvboDJ0fl4iXObybJ9w5pVP/adKOk2Vbyov7CbxCmz8
	+zuLcf287wGL00hFw==
X-Received: by 2002:a05:690c:350a:b0:7bd:5b06:b35e with SMTP id 00721157ae682-7e05ef1ae64mr9213247b3.47.1780084545976;
        Fri, 29 May 2026 12:55:45 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de689e6c03sm9886377b3.22.2026.05.29.12.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:55:45 -0700 (PDT)
Date: Fri, 29 May 2026 15:55:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Danish Anwar <danishanwar@ti.com>, 
 Daolin Qiu <d-qiu@ti.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Neelima Muralidharan <neelima@ti.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, 
 Pratheesh Gangadhar TK <pratheesh@ti.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.92aa2ef1162@gmail.com>
In-Reply-To: <20260527-hsr_ptp-v5-2-158a7633eac0@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
 <20260527-hsr_ptp-v5-2-158a7633eac0@linutronix.de>
Subject: Re: [PATCH net-next v5 2/8] hsr: Use skb_clone() while adding the HSR
 header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293222-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linutronix.de,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email]
X-Rspamd-Queue-Id: 0830F6081CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sebastian Andrzej Siewior wrote:
> hsr_create_tagged_frame() creates a new skb where the HSR header can be
> prepended via __pskb_copy(). This does not copy the skb_shared_info part
> of the original skb so any timestamp request is lost.
> 
> An alternative is to use skb_clone() where the skb_shared_info part is
> copied and then skb_cow_head() to make the header part writeable. This

small nit: the shared info is not copied, clones share the same struct.

> avoids touching manually the tx_flags and tskey members.
> Using skb_clone() allows also return early (after the clone) in the
> offloaded case so this can be unified a bit.
> 
> This is a prepartion for PTP handling where timestatmps are requested.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

