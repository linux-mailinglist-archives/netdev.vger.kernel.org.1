Return-Path: <netdev+bounces-234196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4ABC1DAAA
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1B93A9595
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE053093CE;
	Wed, 29 Oct 2025 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="vx797a16"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15D2F656B
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779819; cv=none; b=HX4ZTDaz7OSgBWUWZpNsDvyJ9LBSTA6UwSAMOkLyNp0qD8hQGPD78XDpp5jg8lr70NGPPY3LezGD8YwXPDPex2OJyl8dQ8UoOjGHm7xGpAvRJcHuCb05pI90C6C6FXaFjcr/nNzQZXmP5pNwm4WoOdSWx3cK6ASiUXHjqh0nc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779819; c=relaxed/simple;
	bh=JUeejtpj8GTJk/bWvRgUfL4yXr1jHbbKuz4+egibNgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1s6MkAGzOqs2Hp8Bk3mqR/hlfBnPYaUNusr/N8S8CpHw0zITZXD0QI4WRx5qt0PAslDOG1hItc+Af4FHKDbRMaNVyNZKhF+sWdsJZ/EeYYfKttEd9WX1mfoeBlyzp19K3EOMOljZVAk4viXjLYt0fg07XZVCgchZI4p+D/jpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=vx797a16; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74526ca79beso233955a34.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 16:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761779816; x=1762384616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W9npAGNAvB/GkXlLNAKo8gMpxVLoAPVmTQZH+Cu98zw=;
        b=vx797a16GhyevlG6eW9xdv6oVXq4ZueRsiBdYmoOlTeNukujb/YgUFKor7WcGMlTGd
         E/9V6wsQFkB3rr8mhS9mIkSkmASqDudOCfRDBejtaciHsGKKGRT1q8lv/Pp09Cts0gG1
         FJDUChH4Sde48oq7NYKjzKMnkLHM34FM6TZ0omb2ZQkl0k19yFhp1dyEwncvy0VOsoi0
         UlFq1+jZWvt8yQI7RqQtlIoW4VvBE6QqptOs5JARwBqblJuXXNnFuHBCrkzlMsBsv+lF
         iM3CLXCt67AeinNOuuAF2CLL5T6r9biIfqIQdBO/hJFN4BwmdOtVX6Bi+m721Kp/HArP
         Q+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761779816; x=1762384616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9npAGNAvB/GkXlLNAKo8gMpxVLoAPVmTQZH+Cu98zw=;
        b=kzIS4IcSmcb4Gs6ddJEgHyWJjV0HY1gt3Psz4Echv8FhjNmrJwUsdCjMhl6mGPGyrJ
         1pFU54lV/LSP6AP66nO3ul8i8VgeJmVOhRMtylQ2u0KFBTFQGpCoNd04pjhrF9w+LK/H
         Kve6fRbn3u5WtKOUdLymIIdALhXP2/Rlouqe4ei3Y0uLm1mwsK6oW6dmh1XD4O7Z7Z/C
         2poaIkEKtX0pBqyuYyWEglK0ERPmZ4dqydOf26hEhiAThq2e8stoZhKYibYeURl+f9ok
         bhjx5rTeuJhUm7ITnCtbfnlpsavSLZeccqJjjShQPUvPZc36JztSK6zOxDURy9tHCDYn
         XJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiLhZBC03+KNtP6E8eEDSN/e8n99hV145wSeZ0dnsi6cSPpnk1C6MKERRWwXa1bCBes3flti8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj18NUb2V1X/5Tht/MQn5v4xhVWwkIkMf3VINqOk4q6teJRF+o
	VTVhbOrxv/xJrzpcsYt2eS7TtCuDWNXMqeUSMy/2XQV2zkVBbN9R59ownw8eYCoIFZc=
X-Gm-Gg: ASbGncudiJjKQv7/nEdPyc9faEKEldeJBPihRgWoJSXU3yB+WpY7pD4DnGnDrcnSDXh
	HKDUGQzRj00IuYgfmYMObuZGti7s+pfHeJoGRzl1eE7zzGm60eVWK9+3tUqtWhLuFiYSBvKG4Vu
	ieFAZkl+Z1G1uciAgsAhfpfTe+nMnOEfb1m9x6g5KumVGINI3svAPMIDmJ1RYWhkfErWiCiGIHd
	1cGDTCWs8RFGDwjrwt0wagQGUmPj4S1uqFBPWNDHa+vOQvQ/AkYCFPieKCOP1pnlgvomlWRaJHf
	Lrty+hBghqXXXawGajwIwl8szwrKj+3vGkDZFHuCb1DqFK2l9yjs8VYeJ0rbhgY8tB/VAYOrJdK
	fOomccFhHVwK0DFYVYWJRLTHgQ421tNdtSqsPMWxL2MtkaIdcgKiSL7+yroGVPaUrsJv+u7jJQn
	HvHBZ724niGglRUqbboII=
X-Google-Smtp-Source: AGHT+IGcWOsufyfCBaHb0HQVZelrHAbKEeNnGWYfHdRQh0ZHXnKFny/zbfmewmRP+D3U0mdDU64lLQ==
X-Received: by 2002:a05:6830:6a96:b0:757:aee6:4a59 with SMTP id 46e09a7af769-7c68cf4bbf6mr753917a34.18.1761779816418;
        Wed, 29 Oct 2025 16:16:56 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c681eb5595sm1336806a34.3.2025.10.29.16.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:16:56 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 0/2] net: io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock
Date: Wed, 29 Oct 2025 16:16:52 -0700
Message-ID: <20251029231654.1156874-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev ops must be called under instance lock or rtnl_lock, but
io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().
Fix this by taking the instance lock using netdev_get_by_index_lock().

netdev_get_by_index_lock() isn't exported by default, so the first patch
is a prep patch to export this under linux/netdevice.h.

Extended the instance lock section to include attaching a memory
provider. Could not move io_zcrx_create_area() outside, since the dmabuf
codepath IORING_ZCRX_AREA_DMABUF requires ifq->dev. Happy to do whatever
here, either keep this extended section or relock for net_mp_open_rxq().

v2:
 - add Fixes tag
 - export netdev_get_by_index_lock()
 - use netdev_get_by_index_lock() + netdev_hold()
 - extend lock section to include net_mp_open_rxq()

David Wei (2):
  net: export netdev_get_by_index_lock()
  net: io_uring/zcrx: call netdev_queue_get_dma_dev() under instance
    lock

 include/linux/netdevice.h |  1 +
 io_uring/zcrx.c           | 15 +++++++++------
 net/core/dev.c            |  1 +
 net/core/dev.h            |  1 -
 4 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.3


