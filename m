Return-Path: <netdev+bounces-201547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292FAE9D91
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD9172EF6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FF02E06DC;
	Thu, 26 Jun 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6g2y0h7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BC21CA0E
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941264; cv=none; b=JYmPULAuT9Iz6s1eO4gG9ipnFAxlS8joBk5xLglqjhgcK+RkkO3EOvXRwo1fgkbSgUk+vHdth9mCTgTa/mOfokRtxYmbBUeLl4YGNkOSgsz+KulftpzGNl+R5X/pSdozP62MBWDYoAR7f7NKQ8CKAH+jgBAl9wu43BbjUsgczIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941264; c=relaxed/simple;
	bh=xYq3YlHWLcpRuhf2uzNsPW01IwpNDK6stCyjZg2tQk8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sxu5j/71j/9MWM1GgVEEEX7mrWfCR96N0QEJL7rs5kGV21MzqtRCzLqd9flkXEkcnBzHLP6zRiUDKdfK2+1zUwcrMZHAQGhbpwU5TbIPftrxcB0rcE6S+rHi1HZtS+x73KisgIRNa9rbBKuEIsIba7DoxHfcT5+V84+giqqOfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6g2y0h7; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a799f5b463so35865001cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750941262; x=1751546062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jQiAv5rnmhc+TQ8MRbuHQLLf/14DVw6hqGtzGmXV8dU=;
        b=u6g2y0h7xOFLfdFMs+shsTkiXpoFPs8uPxJP1xTF0GutddUA3mM9Nqi6fu4A380n3A
         wDvVToFudztXQ4Mvgqbziv43nsIvuC2irvpo+TCyOsAAxdk5qGYAcUuVuquoYGpaBJ22
         Hf9Nxs/2XJJ5lKeUxmRlau5KhvDeo7uLyVbuB7Ealp5gZMBAHzgP0rJ0KkVCh/N8ep0x
         11k15l+xxJjcJyrENLA60bU42oCcT3M8U7wZCG3DEup3BWT8Bpz6Qlf8qoMMAaSWpi4j
         E1SKwAmdzEshravY3AGPSjGe5H5Aja39QRI4XozRERQK7Ah87RWCmnUA8y+E+LnKQzdt
         gpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750941262; x=1751546062;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQiAv5rnmhc+TQ8MRbuHQLLf/14DVw6hqGtzGmXV8dU=;
        b=TKwBEco4J9sb4uw/QnLQlhqQaGyWFeBNEHCr16a2jNGQrKuf5yWaQdSpSoj+7/Jymw
         ZswItORPQrHDYisijWSTO7+oM/lqoTHSGEGzo7iVrkuSVqx5dWb2tMAY/nvrH90E+aQb
         AHZmk0ZGr3dHfXrpgwjJzQEpAE06ipE+SsgiDt74GK2qURvyVvZvZEhMdH9amPNhy46K
         qWxjUeIEvj7t7d19gsgoTIPAObNOzhRuZmD0TU+2zxWXw92Ns61+j5Z/GzG929/3dqLO
         eykX9y4OXq0Wl0gnQVI3tNJHJqLC6ofaFbnb0c6Oc5m/L4ucv7vJEfRDZ2fm8o+ZfU1O
         aoVw==
X-Forwarded-Encrypted: i=1; AJvYcCX1ae0nUF/9u/imPKvRIe/qkaf2crvWLr2jQCzFKM3pajaJz8eGoVpT/2rVKETiZ69QZMmDN0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcSKerSUeh5N47/fstcQGZGnRdMtpytgFOhwVMPO9gx2brFB3
	Aqs6AkOKLyaJfTD0br9o3n0LFITEt1oX3OBG4OQ8XcSHB1xQtAUU5WvW2EqeYgpzKV5L01ce33V
	VSMeNNwZ+l5B0Sg==
X-Google-Smtp-Source: AGHT+IFNO6ZqLiXAbpymiRQ9XO8I/pro5qkIcfMh9SQ1BnKkBQpjd1p01qe/JuQyNtMtTz3vTOBXzku4kXqfMw==
X-Received: from qtbcb20.prod.google.com ([2002:a05:622a:1f94:b0:4a4:310b:7f12])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5c82:0:b0:49a:4fc0:56ff with SMTP id d75a77b69052e-4a7f2e79e8fmr56823801cf.12.1750941262229;
 Thu, 26 Jun 2025 05:34:22 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:34:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626123420.1933835-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: fix DSACK bug with non contiguous ranges
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series combines a fix from xin.guo and a new packetdrill test.

Eric Dumazet (1):
  selftests/net: packetdrill: add tcp_dsack_mult.pkt

xin.guo (1):
  tcp: fix tcp_ofo_queue() to avoid including too much DUP SACK range

 net/ipv4/tcp_input.c                          |  3 +-
 .../net/packetdrill/tcp_dsack_mult.pkt        | 45 +++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_dsack_mult.pkt

-- 
2.50.0.727.gbf7dc18ff4-goog


