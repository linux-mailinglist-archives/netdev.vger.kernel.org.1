Return-Path: <netdev+bounces-287166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNqfEqsuA2qN1QEAu9opvQ
	(envelope-from <netdev+bounces-287166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:44:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92B521823
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7573B30706B0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7FF33CEA7;
	Tue, 12 May 2026 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyGQDgO3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHsWbYEF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF43E173F
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591932; cv=none; b=dyeS7ZMyuhnL5aQh5W+3GqP/DUVw/Nmax+TzxX9vM8Ew4PEMxCktntscBQzordYfv+r9siVrMWP6fzPjWo89J0/gVUe3vrtyflpPrZfDkW9rjMyn5GhyJfCo5SGqPFBs2X4areSg3zMi0Ypi323IMWnK3UKVQjLutB2aeZ5LEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591932; c=relaxed/simple;
	bh=oJmQu8Di5waoLooSs0lgzRwiGz4G2MGjJbUfI5fl+68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSy2CafXVBLp3mLC96bfu6of1dSuoiaAzcSROdezK76ffKIkMP0dGf8zug1AlwUE/u8lj27ICD32RrvdikMCrLNzLuUMpqvxZtYKrwF22WOdtBmFALnDdE3/rcl50kNlrdSxAjhrw6SBjfOIFWgIVSa02IoO3l2Nv6NyBo0ksMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyGQDgO3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHsWbYEF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778591930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ8M+MijEct0ZXEThMl7dvJEZhdm5E1OCW5rqU2+pPA=;
	b=FyGQDgO3H2ykWHzuNXYpJBeFUfCCOXNNDUSjheYGHZ/FnmRlmA1K9sFIkGvFlSFib8fG7x
	2JXwz6HGSdYYu4E9konafAOGStcMw67t19eIcxP7yZiAR4WS32z9j8CklYJvsUQP2rJURT
	FplWYW/hXEnJ3IpWlepnahaNFG/D8E4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-_XPJdpNJMoeM7e7qrMucTQ-1; Tue, 12 May 2026 09:18:49 -0400
X-MC-Unique: _XPJdpNJMoeM7e7qrMucTQ-1
X-Mimecast-MFC-AGG-ID: _XPJdpNJMoeM7e7qrMucTQ_1778591928
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d1b294dfeso49885275e9.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778591927; x=1779196727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQ8M+MijEct0ZXEThMl7dvJEZhdm5E1OCW5rqU2+pPA=;
        b=CHsWbYEFOF8OHC0hfmmdGHpdZ1kQDVaCOul9qUvLcdVCmxQbZ/CUatjTf8PLET/DKY
         lJHGjzWvyuW+Cv33rYAjID6XnJQ3TPBY9WCf3F+VcNtUdg2cM6IBMjNQUn7qohbiUJqa
         8vJzwqLHmM7+PUIOslXPCBpPnLbpnntGFyHS+dLYttzOgxJGBRCzH2EOBk+IcpD2Hydn
         Hmmm5rmBL0HsSFKFsQW+AYbxAOIPvIGV0t3HmXx2ZmrZL/s2+FibCuQiGQwyHnI21Om7
         HwTP/XGv9xFjtPgw1b2mAra7qUIStC5Fh5VvWWr4qw0kFjTNAtMb1OE6hUOCRAuk0qcZ
         DfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591927; x=1779196727;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQ8M+MijEct0ZXEThMl7dvJEZhdm5E1OCW5rqU2+pPA=;
        b=BLnTW3adCmrjNOBDsEO1vCa05m9Vbuul54CSH9X3cdfbf54l5ucMyY3nnQh4REI8Qq
         VgCBeebFAHy6csxPzNV9tlkzDBJjKpb18X+Q+g0ROUZdszSNG8ZzBtaczICjvaM1Ii3n
         LBjWoef+ov9kuX7EVk7zBB3CLC0UTNfnpN4PhR8IILBRKxtBxCvyViBJ9Xc1+e0LnSDV
         kifdG+dSzLakP0QkoTArq5WTpPPLU0YGn+V3795KZI6t1uwS1T+/EbB1m323hoUZVdpl
         4WbSzhUkLQAydSSFc05ehzrXo9RhePp2RvnBQkORbYRLXFm/cdW8R2b1HaZ8gzdXSha+
         Q/dQ==
X-Gm-Message-State: AOJu0YwSVhlXvKc1f/OYzCI+CL68E7Up+tYDqZwhJRiACthsmOk3ifP1
	G9CORt8QAUHqkbqnqTy9aa+TnLU70pym+/PTPQIDEfXRBX4oYtY44+wHEgEAOJw1WGXQRv8wem4
	C4iY/SozqLwATBf6Fhw8U8De3e6+4vUg5piL6M5upt8iS23YXo0PQxUJmk1qHKhD+pg==
X-Gm-Gg: Acq92OEe+WjZTk4Z3yzdTeYbPF3tHrT0cqzbG8qTWVvhwp5kCTACFURkMy+bv5qk0ot
	6ldxouZXahPqUiayrBjdcqkkoivfe6iclqfG/eg8Iq3uARkgPVmMCUS9HkxjwGT7OvN9OfWxZT3
	BlVRjdSHneRhZXmSs5ZrUbFmystkUsiluRk0hrWMQp+H2Fbtfef5+Y4gkHhnLd/1P7VA55Y3q87
	aukMXvXhpDvsOmhakuJVa3X7OjIbTmbxpm4WTT7FUINzT1CgfCc3hz+AtWdnAhUchNvjgl/3aUf
	S9zC/9xcQFFFO+CNaS64byTG+pKzxh9fktoeoA2qfe9HS79K/5Zt90BPXRPFnoCO2ivcxn2U+ZV
	Sf3rARi7uqeRo1OiURPhnlUkbZruTSm8dgieLQZiKC78RhHm6kg3hMu0=
X-Received: by 2002:a05:600c:3ba8:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48e707fbac7mr238767185e9.24.1778591927519;
        Tue, 12 May 2026 06:18:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba8:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48e707fbac7mr238766485e9.24.1778591926996;
        Tue, 12 May 2026 06:18:46 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f428b88sm21742135e9.16.2026.05.12.06.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 06:18:46 -0700 (PDT)
Message-ID: <bf110a3f-331e-484c-8a0d-0204ccca104c@redhat.com>
Date: Tue, 12 May 2026 15:18:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] net: ethernet: cortina: Fix various RX bugs
To: Linus Walleij <linusw@kernel.org>,
 Andreas Haarmann-Thiemann <eitschman@nebelreich.de>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org
References: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3D92B521823
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,nebelreich.de,googlemail.com,lunn.ch,davemloft.net,google.com,rere.qmqm.pl];
	TAGGED_FROM(0.00)[bounces-287166-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/9/26 12:13 AM, Linus Walleij wrote:
> During review of a minor patch for a bug in the Cortina
> ethernet driver, Sashiko jumped in and pointed out a number
> of nasty bugs.
> 
> This series hopefully fixes all of them.

Fortunately(?) sashiko is very good at finding pre-existing issues, and
this series pointed to another set of such things:

https://sashiko.dev/#/patchset/20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b%40kernel.org

patch 4/4 will need updates, too, but the first 3 are AFAICS good.
Since I don't see dependencies, let me apply them.

/P


