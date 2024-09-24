Return-Path: <netdev+bounces-129563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A207984828
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6F61C20B45
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875F1A76A9;
	Tue, 24 Sep 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zAn+DstF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2083CD6
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190182; cv=none; b=MmTxGTR4hr8RpN78EpJHUeXbj92WKalI8zHtetMoFS2LhexRsynj6zej9pILSZAp8f3if/A7N5iaKtC/EVPpH1Hc/fq28SWjqEE6T1EXPD0e6kyo0xXy+V+uHnA+iY4w31u+MrUMjzRGon1SI9MfjiEkpIxDPM07SLeLexP7JO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190182; c=relaxed/simple;
	bh=E1V+WkQUS8kNf9ydrHWdhQAzdBaDV09fpPiaqZY3bUI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hfHTvOVrG/VgWIBNaV3DXMaOk349Vaf2peGrDjnh9Uq2q0Y14bykVOUxb1iHNDQ1weuqxG25lEEOxKNF/VpNpOw8LhwQEDdT98ECzhIhDfgLEpxARXOtHYhmCW/gU6W8CXJcasC6OZ8eZPsMcnHpYmidANqM4WAf4r++qnjaiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zAn+DstF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e226d4c2e74so3498687276.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727190180; x=1727794980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T3cpEftIOPVjQSyfB9Mi4SYo0jdrR5nF2+oLi9WNNkU=;
        b=zAn+DstFdW1qqNOET7BLH6238NVS7BmlegrHPnOBEzyyEKiJbiZcca4soBDwZ9WWZd
         B3opdhXXTqm/TzPhm8I8oDgNNmhGeFmODcCA5SB1rCUwresFqH1vNixqXXx3yKgr4c+F
         HLxGLQzaJqLASfjV+7Ed9ivhonrK1oEIR3TOwads+oYEVqm+OEVxzSUZERF+br6i3Jhu
         e7642OCBkc6q0gCULRyxqoOiKN/CaOWbNHNzbqolMwcf7uoiYR08REfr+dSn3Bzrl7gl
         vFKHJpQTyoP8K0CAhh5qdQ4Qy5F7oGLPEw9oXbgCbLTt4YCxA9PJyeuWTQ9EP7JbFSls
         MW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727190180; x=1727794980;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3cpEftIOPVjQSyfB9Mi4SYo0jdrR5nF2+oLi9WNNkU=;
        b=GsU5AkmBu+JFpTW+wQ3WS2jkZSfOkzkwNwSaTeDLBJ/GeRGIMsanJoqggb+ez82GyT
         Ms7K3zbi3lRzFmjxBAnV8v691Gbznhkymmlwjj1dAyUKjzvd1+J6EZLqHASgVUMecupo
         LgXonyivN8DVQyrM2hu0l2fodfUWgDMR0JERIKVLhVkCf9xfx1Atvc7NHyuY8bcvoC5i
         zZ+4cb4hRPqPXjEQFt9Sd0UplqMTb2peEz5wypc5NK/cYaZwEntwgKwSXXJ66EGR3ou7
         xtA5lU02K7w+IGOqZwGEDCU1tFNChhTU+N0NFplLrMwR5vDnKYZPt1JErGpIGieuzGdA
         61hg==
X-Forwarded-Encrypted: i=1; AJvYcCWNOjzvdOKdLXykpoOJB4OElW6UvNVTpnUUhQ5mlWXjlXmTb90sdfrwUwIxxRU6DVICHAI0mPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcwPzzpg/lnUqb1qZWsvQXYwUSZ369qPmy5zFGra/LW1MiI5zh
	Eqnh3p9ORPHaVHMOf/DS86nobN2R11SMUiTzI/D+GNdhLpHH/PAnb1u/C36drZ+aHOLxtma1wCk
	tHex2N63Vlg==
X-Google-Smtp-Source: AGHT+IFAsBB2938nM9V2t0vHFF88zAk8zazjamaznGcUd7tVpkfqVyhQfhhX9Jn2UXSRxE4zi3F02Sx/qJPlmA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:8751:0:b0:e1a:22d5:d9ef with SMTP id
 3f1490d57ef6-e2250c39befmr12944276.3.1727190179786; Tue, 24 Sep 2024 08:02:59
 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:02:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240924150257.1059524-1-edumazet@google.com>
Subject: [PATCH net 0/2] net: two fixes for qdisc_pkt_len_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Jonathan Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Inspired by one syzbot report.

At least one qdisc (fq_codel) depends on qdisc_skb_cb(skb)->pkt_len
having a sane value (not zero)

With the help of af_packet, syzbot was able to fool qdisc_pkt_len_init()
to precisely set qdisc_skb_cb(skb)->pkt_len to zero.

First patch fixes this issue.

Second one (a separate one to help future bisections) adds
more sanity check to SKB_GSO_DODGY users.

Eric Dumazet (2):
  net: avoid potential underflow in qdisc_pkt_len_init() with UFO
  net: add more sanity checks to qdisc_pkt_len_init()

 net/core/dev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.46.0.792.g87dc391469-goog


