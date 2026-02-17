Return-Path: <netdev+bounces-259065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNE2B6qElGlBFQIAu9opvQ
	(envelope-from <netdev+bounces-259065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:09:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D49614D6EC
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B32623047BD3
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4936C5A1;
	Tue, 17 Feb 2026 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFmQQRDx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4736C0CF
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340897; cv=none; b=pkCvytLewMTafopuiePyiIDq+WQvhdaDdFsvgxR2U21ru4Cj+9lAjkrvc6dWwORlKYgAb7PaJmCOITi0ls+aq6y28wUIrPQhIKVrG93MFrsLiimqAEMNtZzMnPEfwb3yxHBWpoEVjbURH332kJ50H7A9Q4dq3Z1UBj7ek7wz9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340897; c=relaxed/simple;
	bh=Q29mfyYABoCCBbMa12iGQyG61YzQf3utMQ+az0Gxtro=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VclcsZ4c+JvmOZmEAyUnzQZ20RI5WX4eFtgO1Rqult/iSpfXb8OGPmZJQzNKt/IcixDvYDn6NWMYzDHT2Dg4HyIMOc+DTrMr9u585jyHBt0/vVrBQIzpMsTzBm/7zDw5MOjudaBSY01GISUp2iqpVpheLJb5DCEMattjG8YcmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFmQQRDx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-790b7b3e594so41902867b3.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 07:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771340896; x=1771945696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQgQfBeW9WwwpkhXMbYiY9OuLLnQ+E2z1LfmruKn6fQ=;
        b=cFmQQRDxHSVCW9Y79FqI4ZgdajnWuXeUhkVttdg/1HWwY54lBrpdM7NG+Vq3piATF+
         DRImWgOoPK9eFLp4rtSehJXNI1urzwE5m96mL8WHqYH5ERljkX6sbEJwcD5p+LaSCqix
         wfo75Dj51MWAw6kk1FMIgaIOF14EtI5xTzUDJDjZZw2PsQfbXuwnRMpaC1lQRHVvCQd7
         0m+8Waza7BzPqYzjgoICgJZdPfMf4ZwZdsGj7tUEGkGyKetx3jogA5yakIErgP7erXCC
         zwcVVoupko2RET5+UZQA3KcEpARwpaJ9x993K9gFX/iHj25TXpX1q8DKvGHbbr8iUHwy
         tBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771340896; x=1771945696;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQgQfBeW9WwwpkhXMbYiY9OuLLnQ+E2z1LfmruKn6fQ=;
        b=Dwip8z2bKg0MiqoIofwYh8lZPJdBB3cZc+XnsDeyJATzqjPI4BMPQ9S8ZhfqPuscZb
         m7JmNrOA8I6IupzyZ8TnfrEPyRKdFlVw1MF0s3giMarHegrT5NLrg9lJLnLAkfSBGhkr
         FFtB5ZkjaCtFclI5do0eO7WsI80Gs3Qh6HjdXGgLJncVuQ0x9uWfGpe9wExel5OJA5Xb
         aheOUekMUaAVzMm7hCjhFUquSErh5XaRbdfkxiHkJfFdvkRBbqgZR8oq6tUMRdoiS6t4
         USh44irup8WsVDY9JL9RC4eWvSEsu1gh7wBka4KmCvEi7z2+PfgV3KfvDJgF0Bj5Avb7
         aNWw==
X-Forwarded-Encrypted: i=1; AJvYcCXw7oHJDklIfGgcvP1EjpdJw3u587i08bZJugLTTvNy9xuA08WZ6jGzyxYROVdXHFf7UulIGio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jW448o9t9tT6w1cEvV6tuAiGrn8nm3TJZuusDGkzBs34UUkf
	8oVgidE1CPbVclf2ptU/lNlBMMtBl4HOymhQhYBUVcFNVk2tapW320rz
X-Gm-Gg: AZuq6aJPFcV9igb+UPXGpZbxfjaWyCDhir1sBBXrwocz7J8TywYO/U+ybyDA+ezJQW3
	UXErzEVT1aRLje6NCBgDamuL1D8d82IbnNr3cdboTMHxoP5OW7YcilKFQf9/kWO0HYPghFQA1pU
	2NX6DiFex0HNikZBLmZKPLgJpGsRsFmTKiRTEcrvKbWyUNJSFk7ezm/BZqNzG0sdpN+x+9kvWW7
	AiUTFCmf3w8j7FUcPoUvExkDgl68eITGdqb6CCBFg48IYpo0NFWh+dXEKoqrNiQHkwhWcJswgbj
	DytBIN1lsHs3rbCMojp14cqcgxKAiDaRhwea6OQZrL1UKtoXI2Z5VJo7nVLKv8RFLi3gvHVieVw
	IVA5eNb/xt3BrZ0gvFiWnS2wHuOthUOtYMPBGdqlHnLn96dEegNfKfH5NM9pvNWXbDpWleBCgIY
	5WMWCWrM5VOPynigWdGOokxjZl/tkHtB8/EZIgITKqmPYvnlFdGcINkXUrDdkqdbCqG2hsrU4=
X-Received: by 2002:a05:690c:18:b0:796:6d46:8f8d with SMTP id 00721157ae682-797a0ccf086mr97018107b3.41.1771340895660;
        Tue, 17 Feb 2026 07:08:15 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-797d142c2dbsm20707177b3.47.2026.02.17.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 07:08:14 -0800 (PST)
Date: Tue, 17 Feb 2026 10:08:13 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.36474c094112@gmail.com>
In-Reply-To: <20260217142924.1853498-1-edumazet@google.com>
References: <20260217142924.1853498-1-edumazet@google.com>
Subject: Re: [PATCH net] selftests/net: packetdrill: add ipv4-mapped-ipv6
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259065-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ksft_runner.sh:url]
X-Rspamd-Queue-Id: 8D49614D6EC
X-Rspamd-Action: no action

Eric Dumazet wrote:
> Add ipv4-mapped-ipv6 case to ksft_runner.sh before
> an upcoming TCP fix in this area.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

