Return-Path: <netdev+bounces-285711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK8ABT6X/WnBgAAAu9opvQ
	(envelope-from <netdev+bounces-285711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:56:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9F4F3675
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA9F30037E8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93AE3806A6;
	Fri,  8 May 2026 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7Z6cYON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AB37FF47
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226975; cv=none; b=bCqLMWC9Apm9GY7oD367s4M5CsGnTe8I2FUSoUOT0rEQwLpHCdP2xZm/3BKpvl+tDhnLPJUFthpdI3y7KHzgtYB1CAhG4R+jhba4jQUfncD0aVwzr0qApL5oW4xkqHtkNtwGW28xV/msNq2v/voHOTKkBTUtY92HT8KpGdl/7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226975; c=relaxed/simple;
	bh=QxqWhck90nRyAuLxI/aJEO388vUHtx/+6ylrqU+FxrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q242d7M8X1UZx7eMxCm6YtVHuL6Er0xrHotPHM/jV8ji5qAaoehSAwppOpwio9bNLtx3/9+9yaumEApAPvnQ3uxQi0VpQMIVdNNyCMEbLJAVn/BM/OOJgJDZzZWZIMpeQMlxa+WypwhnljfRRJT4GUOItlcnOOiUlN4buk9vu8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7Z6cYON; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de4e6c5a30so1765164a34.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778226971; x=1778831771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHciCBjHg+XtpY+/D0jNffHfXvfNbDr11DUMtmP6X2I=;
        b=P7Z6cYONWHZEjE/5ED3hchiwYTtT1qHBt2rHxwosDeO4K4SGoGmS7o/66aS3gIzjhy
         jGYCcyzqXTRjaQVkhLf5zspU1mDxM0R85S+/e/KBnXVh+ywh4ERHw9k0lNspDHHC9YjM
         bhlyB07anpBkOJxnF0/9oBps7z6L+6pLH1u3W53tuifpgex6soFyZSlkzFmQI/SRWZrg
         NnJclskyvKrDU4A7ynLoD5PDjNpDBLwuksE9QhyXNfyu7lXEbFqW9XxgTbuCmrh4EZby
         xhBMYk8+NqOgmfq4sFFq2VTF0xVJWuQjfl9daUHk8+G2P91c9u46DtOKRf7TG2KxzDkX
         LKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778226971; x=1778831771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XHciCBjHg+XtpY+/D0jNffHfXvfNbDr11DUMtmP6X2I=;
        b=jL9L3ktUPluKSaPjB/ZPY1DFOs/vadYStV2wGGICifETtuQemLBkNcR5Z0L8uZxzB3
         jcLXPZIjeLla/avDb5q42vZ82C4k0ttjkVNkAZ1xlc3XMue/2e5NwmvNpzwLWx5pFfej
         OjrcB0L2IutehE05W6N9qVff6UP0R5DJFa8Bm0qiyKB1OAJZTv3aVIEhcTM0owi6kDWa
         e36WoKL+6PyiMlbabQorwUc8RER1Kx+Tl3pVJiY2U9+lET5SaIjU/k+IixcIyKsNzTdt
         /oI1A9D6t2SGzpTae2etpSwMOMa6i5sQvIvN9+0OwHiffUqkgYdgq/Z8fMPgIBWUPfrC
         kH9A==
X-Gm-Message-State: AOJu0Yw8YePNwA1y3MxWwoIw2a3BdwLJJ7YPoCZKEYydLCpzglSRa9OK
	nyyjRVKP8/w+r1U09RZHt6EfBE+onfr801+RoMK1kVUjRso3jqIHPdCT+2zgOb7IPNbnZg==
X-Gm-Gg: AeBDievF12sg0KJF7iNFJmf5sHg4em6ED0BL/xq9BJDd4oZ3pVEf52Wh/K0N4rqxLLx
	t4ByKYrYrOFNYPjbDziay9Er7CS/IT/HpsNLELgJwuVu2xqnARt+P7Zi/uOEmKjjJXxZMgGIoXn
	WpSQVQ9CkGzqwEbTPxZZksH/a1HQb1lHYL03GFz1jKcTq7mcVqM7gDLigwuz4D54yM4y19enZzO
	jE3WA0HUQRsgyoXJ0o58os9VIwt/MguEwfc693jW6Djz954123JPYAlJp9xGmqRMoJM0tgl9ESL
	ygFPs9iAoF8m2wrFZ1Z8Jr5EZerjamum3qrMFlRbC5nwKyYKa2l4btMyJY62ZKhN7ivUebWK5mR
	O2LDYDNitvPRNflu0TClPPzzyk8a5UIyVh7RBn6vHfRjfkACo14rmmiW14NRUJGIyfH1KvSgYw/
	tbkVNoHnGOiOueDD5TbZE4h6mO7g==
X-Received: by 2002:a05:6820:80a:b0:696:8c3f:d7cd with SMTP id 006d021491bc7-69998c8f271mr6396879eaf.4.1778226971426;
        Fri, 08 May 2026 00:56:11 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c767d0sm686246eaf.5.2026.05.08.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:56:10 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	Minxi Hou <houminxi@gmail.com>
Subject: Re: [PATCH net-next v7 0/2] selftests: openvswitch: add pop_vlan test
Date: Fri,  8 May 2026 15:55:55 +0800
Message-ID: <followup-v7-20260508@houminxi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507131541.2331771-1-houminxi@gmail.com>
References: <20260507131541.2331771-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88E9F4F3675
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285711-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Aaron,

Just checking in on the v7 series. I addressed both items from your
v5 review:

  - Removed the slot number comments from encap_ovskey nla_map,
    keeping only comments on entries that differ from the base class.
  - Dropped the explicit modprobe 8021q + sysfs pre-flight check,
    relying on ip link add type vlan to handle module loading.

Is there anything else you'd like me to change, or does this look
ready to move forward?

Thanks,
Minxi

