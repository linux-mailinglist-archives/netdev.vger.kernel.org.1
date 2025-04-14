Return-Path: <netdev+bounces-182158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25173A880D9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE3A17591D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD772BEC28;
	Mon, 14 Apr 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zuqh7Iwf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075E19E967
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635146; cv=none; b=PwKxunCYlWZGokhgFe6tM7UZhm+MhcLfDXm2bDM5jkoUU9r+J9wv/q6skcjgOy11AG3wAyokxAwCXQAyGZNadoR4yerVTLmSvIJcqsmr0ET+E5f4Y0XPoHiLUrJcy/WB2zXo/2oPjk0Cfe11fFzME4XtvhMqTwfd6mZsIGq+VPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635146; c=relaxed/simple;
	bh=56qFWRXosue5jkK4ieJXDdNAh9E0BoE3LFFPPbUJmIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vDpcsiW2xON3sPsYVFEKqCFIcrLPAdLvExtHBRr7gtGjxkYcC5syghVWKFMVVqlKtFhI4JRkJkTIeStOSX+f2L0OM/Fe9tUC4+uTvSVnrtPepZSpdCJtHuZPvAVP+w39CCU/CfQ2d6yRNk34T1AnHcthLX3tnZiGqIdOyUPtvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zuqh7Iwf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so3605136b3a.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744635144; x=1745239944; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYhvxrgWhBWtcS6YwA+u4XbZB3t00mx+nXySqInuBns=;
        b=Zuqh7IwfEnLZqm5VfT0cOHECHF+CB2PlmdFV3Qoj/PLYqHvqMl0jV1cI4QTQ3Z7t62
         CqCnq35gU5m+i1aqZAmQQ6gahtj3LnbMi+yqDCUlI9FAvkbT0NHfQwjyNLrgVhmYWNUc
         OiPRsjzfYkpKeb2fDrcvQ4SAdzDRaOdRLO4RWTzPQ42Si3mXMSG5e/Nsf1ajNJfH6EXn
         n5qCDHpMhtXOXt/7aUB5dzQnexjz0HwFHRxDMIBZuucLv7JzKqh0s45ReocPRTgHXCC7
         4u+DHtxPJMTXqEYkkC5+nPljUhlq4rZxDKCRyTsijQLiKDpqt9eHZXJrS6WR+pyGQQLF
         i8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744635144; x=1745239944;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYhvxrgWhBWtcS6YwA+u4XbZB3t00mx+nXySqInuBns=;
        b=YCZFRaJZBJvQhsEmJWb7NrD08Lraly+1DjbEoWteLCFZn1GEWHiw+iKDpNBLpKxPlT
         W9kuY+ZBYsQQxxjhqOA1AKzfg1O+629YEzT+OuchCDGREMDXsVV432LXdQSTEPuAs/vy
         OkEhNVH3CuzsWqsLnrWGFN/SoGVvQA+q0l+EM007BF72nvSiXHxbpN12kr8ZuycZpNDS
         y7WC6QIHFEIZldfSdf45kjSbg1jsk2z5ctJA4O42r6kJFSANlWjFTwf+NHsP/w9qGd25
         RnNsMfK9KuH9blsV5073uTmS5EuDFdXrrBWOYtWKBaeZzW+sRtZaP3SYN3Nvrgfx3zNF
         J94A==
X-Gm-Message-State: AOJu0YwJMHW+ZH5Eu0J/0ETZwS2bCgYp4uOEJCWMuCVkq3A8CtXpPkd9
	1OV2cZHaVW5LW1YCs65g+KLbQRQNiZ6Tvo51CEHJmHMqfXD3hjzJHygUy6qXQ0k=
X-Gm-Gg: ASbGnculL1jcCxr+i5ogu8feMR/HoE/dheke1rZ793dPt5hAHRBSM/YOLfFRuiTIEgk
	lue4C4t+xf/dbWTIeR0FC9XG8ULnLsjTY3ja7gvbp/O5aMn0E5zvHfI/B6u/6rgF8LR4rHdXSDJ
	UGfljoq6L4jvtKmA+BLagpklTfZUAUWVJ8HdSQyrKGQBwydOtakhaTz4VP9kOtimKtfIhOkoHkA
	6idPsFjupf55OH5wlGWaHbj+A4gcIxpKbewYzRvgSX9+Jy5vyRNFzqpPVaPkYGC1yaKDNivWC7Y
	bBb0h59c97gJ8eJD2uigZlqVZu4paJ/sv90p0dFpeaANyw==
X-Google-Smtp-Source: AGHT+IGC0RX/uQrUhePFlXTh7YYpQ5A3d3ZTf/siyfrV07fAKdFDs1tILodheDgaFrQQySmUT8kQ5w==
X-Received: by 2002:a05:6a00:21c4:b0:736:ab48:5b0 with SMTP id d2e1a72fcca58-73bd11a0b42mr16007394b3a.2.1744635143778;
        Mon, 14 Apr 2025 05:52:23 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd219894bsm6502049b3a.34.2025.04.14.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:52:23 -0700 (PDT)
Date: Mon, 14 Apr 2025 12:52:19 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org
Subject: [Question] Any config needed for packetdrill testing?
Message-ID: <Z_0FA77jteipe4l-@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Willem,

I tried to run packetdrill in selftest, but doesn't work. e.g.

# rpm -q packetdrill
packetdrill-2.0~20220927gitc556afb-10.fc41.x86_64
# make mrproper
# vng --build \
            --config tools/testing/selftests/net/packetdrill/config \
            --config kernel/configs/debug.config
# vng -v --run . --user root --cpus 4 -- \
            make -C tools/testing/selftests TARGETS=net/packetdrill run_tests
make: Entering directory '/home/net/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13                                                                                                                  1..66
# timeout set to 45
# selftests: net/packetdrill: tcp_blocking_blocking-accept.pkt
# TAP version 13
# 1..2
#
not ok 1 selftests: net/packetdrill: tcp_blocking_blocking-accept.pkt # TIMEOUT 45 seconds
# timeout set to 45
# selftests: net/packetdrill: tcp_blocking_blocking-connect.pkt
# TAP version 13
# 1..2
# tcp_blocking_blocking-connect.pkt:13: error handling packet: live packet field ipv4_total_length: expected: 40 (0x28) vs actua
l: 60 (0x3c)
# script packet:  0.234272 . 1:1(0) ack 1
# actual packet:  1.136447 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 3684156121 ecr 0,nop,wscale 8>
# not ok 1 ipv4
# ok 2 ipv6
# # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 2 selftests: net/packetdrill: tcp_blocking_blocking-connect.pkt # exit=1

All the test failed. Even I use ksft_runner.sh it also failed.

# ./ksft_runner.sh tcp_inq_client.pkt
TAP version 13
1..2
tcp_inq_client.pkt:17: error handling packet: live packet field ipv4_total_length: expected: 52 (0x34) vs actual: 60 (0x3c)
script packet:  0.013980 . 1:1(0) ack 1 <nop,nop,TS val 200 ecr 700>
actual packet:  1.056058 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 1154 ecr 0,nop,wscale 8>
not ok 1 ipv4
ok 2 ipv6
# Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
# echo $?
1

Is there any special config needed for packetdrill testing?

Thanks
Hangbin

