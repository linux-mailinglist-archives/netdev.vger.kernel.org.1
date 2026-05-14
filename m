Return-Path: <netdev+bounces-287993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBBSIIjdBWokcgIAu9opvQ
	(envelope-from <netdev+bounces-287993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:34:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFA6543319
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2952B302F9A9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9EC3A383A;
	Thu, 14 May 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BXWxZ3rt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503B1223707
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768487; cv=none; b=UL9xBaw2GUKl3x55ZKPc8wBCTgolU6/rOD6fP6hf4SOydPD1CFJtFJjiP6Wo+Shi0qE4v2nSrpYKkkhYYM/la5Hcvj46nnXtuiiCeKDzV24u08L89jlFEzdnrqB0WJLl9fQnXG48oOFl6JXpFSaL7yv8wDx3p/LbERF/WJRBijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768487; c=relaxed/simple;
	bh=lWQp3LFf8ikf1vRVll7xD1aNTB5zOughHiBM46EXM9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n07QOB1NdCv7WQ896VK+NPJRUn7d/z8eEdvnVZX5prAGOHMF/bL91VyE5VPb32G2fCFJrC2+rK7f1WOhMoq842wTOcUOnaj5Jvj7EfbZKGbvI9ZbXTVlt4R+Mi9mEwodsKf9nD0QRUT962ng/zXx2D6I6fqInmy0N2IqqSdW118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BXWxZ3rt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso73224245e9.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778768483; x=1779373283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1Vb8fUFDim33Dn8F10atYjUlj6r5pe+LZPO35y+z7Q=;
        b=BXWxZ3rtpcUqPC/G0OpXlDfsin57dPWQPsGAvs/2W/p5N9FPsj7mYBnEFurGH8y9ct
         5mdzuNFMqptJCKe8uDeY5Zc3vY3TK5xFblFRzagyzz/lXn2ykkN+Gg8JM44iZIkzt4VB
         tg76+PC9a5HHYtHl9ozAnzxUMm1RbR3mIhi4VmRgdFS05T5/3otsmU9BDV2TAop2DI44
         ctINTuELNZjEDAW0iqJusPbXINF8VrhTekxoq+CJfJbgr+iLhV+UvkARTvRoSNYhBguB
         VENh6zDFg2nTssfD3IEWqN2KJkl0SH4aq7SFEC3QDNaOBgRrj2nkf9+CJWnNfJ/H2tO5
         BR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768483; x=1779373283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1Vb8fUFDim33Dn8F10atYjUlj6r5pe+LZPO35y+z7Q=;
        b=jr01EtKYiMALi6ugC+KyoE9j4Ts+n0qN4Nl6L2N5KZXEwxB8+GIO7N5PvtQ2RuCKOd
         Q5M5XA3T0s2VvDtX6cO/3Bdxjp6D5kJF47UCffrGN5YejsOlNGU6x9ba1pZpwrSGbsf/
         sfo11fTSJ8Xx4kxxKLVrhD+o0qBlcyJh4byPoy7VlLUE95quJbCiewacNeTWr+L1NM/H
         bDbL9TGXBoWKl+tscz/f7DmrZ28AEz1DnqBweNNBOXCrOgtA7U7dBSTSK5/Ka3KzUxmp
         edleyqQepV+9z++M1TZK2ymZGaAVNicPGRoHp0jyXAUxaz2nC/vV8KLMy+YCfTKi8n0t
         Qc1g==
X-Gm-Message-State: AOJu0YxCspsGwVsqqW79aSHzJkUq3xXqEmjJyDIg6APvc9KB/59R2Jop
	1S2qaL6ZqSOJCqtuckll98122ZkUFp81lRgPHmXa31zOgwtaVv7EH3QsYSv3K1lOSQy+JeKjg+M
	/tz1l+1iFEyjzl3DFRmzDoS8gtRWdK6V9yJQ5FVCP2AKLxhf05yA7+pv4wCs/xpDvMfM=
X-Gm-Gg: Acq92OESvZt4VroVS9pnjDPiX0vB0mU/8NK54RArL7lmxljFnwa31e9EAbnntwz3cDy
	pXdlpsI6uTcaUSHsaqqaQMslUNzIsUZ6aRjEsrIU0DH2wbuzRV0CHjIHq4gCtC6r6T7lU44S/m4
	z+nn5TwfmryCh7XDb/eYuAlEaqGc7ZsMbeSIjTB3zP6kPbgXY/qt7GuM5gd7gjXW03oS6+jksfh
	52SP1iME6EKBP5LxReExw8Pm2c3aEpS6Q1m4Z1j19OwGNJLAooRHCQTqisryXjIQwp6aEO1a1Sq
	Dyry2q2FFArHBuq5b86cQpkVGVmMkEP2oqwl5t2pZJoOSue+KDR8+gqBU7OqdrMCNsOjX9sQZc3
	ca7YWvwhiUzrUteVUDp5Q7aUKKNx+/RBxXAnYOuk84udZ1WO0hmckQ6LloF0r8QaCJI9N927pDz
	lmog7kdywreA9whKM4dPHreXshGtc+xIpe/uA=
X-Received: by 2002:a05:600c:4fcb:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48fc9a0ebc2mr118262285e9.8.1778768483184;
        Thu, 14 May 2026 07:21:23 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:ad19:702:964b:84a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd767a514sm19512895e9.21.2026.05.14.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:21:22 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net v2 0/2] ovpn: fix TCP teardown UAF races
Date: Thu, 14 May 2026 16:20:58 +0200
Message-ID: <177876836999.449180.11732560816194067703.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513105521.21629-1-devnexen@gmail.com>
References: <20260513105521.21629-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EEFA6543319
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[openvpn.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:email,openvpn.net:dkim]
X-Rspamd-Action: no action


On Wed, 13 May 2026 11:55:19 +0100, David Carlier wrote:
> v1: https://lore.kernel.org/netdev/20260512042036.19870-1-devnexen@gmail.com/
> 
> Two distinct UAFs in the TCP transport teardown path, both inherited
> from 11851cbd60ea ("ovpn: implement TCP transport"). They share a race
> class with the already-merged 94560267d6c4 ("ovpn: tcp - don't deref
> NULL sk_socket member after tcp_close()"), which fixed the detach-side
> of the keepalive-vs-userspace-close race window; the two patches in
> this series cover the other two victim sites in the same window.
> 
> [...]

Applied, thanks!

[1/2] ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
      commit: da823317defa1abd6893ef57ad213ab186e9c7b3
[2/2] ovpn: respect peer refcount in CMD_NEW_PEER error path
      commit: 02089e307098fe2a19f1fdb3470601bf507a6948

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>

