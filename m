Return-Path: <netdev+bounces-119729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE07956C69
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AD01F222E9
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A396716A920;
	Mon, 19 Aug 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oimD3wgT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B841DFEF
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075312; cv=none; b=YGRct/CgMBX2P2NgA3gWChlUJ2eyjuQzoYBOH8V05XfTAZ7O1Q7QNNBLU+6qlLxa/AvpRjmEMxDyNhrhdmELKhXJvUJ+ptXcIql3xnzWT8lkFliC/Xe/IJ6DZvbscIsWEPnK/RHOsncrGEBWY9xsbxiqLQn3JOrdZE3+yutEVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075312; c=relaxed/simple;
	bh=0W7oWIHPAmGziU3hAySwueH2uO8ZAtba3fHsJmV3S9c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MSCf7AzkPNlSIKuss6RrLhJx/awfVcK6/H9GPp+NBGBzgXpfttD8o0qL6PwGJOOYWDvQHdp6LZH5z76OgKaTNkuOXtIsV39v3uVU9AeXFunS3u/DHmRrrpK1nVHm0azJyS2fy0RNYN5yUhCOoSiwolhsgHX/0zgHOFk8nMVbmUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oimD3wgT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b052c5939cso37700087b3.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724075310; x=1724680110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JOKhhdkn+gAY40WJAVcjb3QkD6ROmre4iXdOzftmIW4=;
        b=oimD3wgT3hPaGEZIC6AoMvidKzqXe1yRGlXSo+Y5Ua7z+GUibcvzzukvy6SpTClJCd
         LB+UR4DpJtLBpbs4ZdOe76a7dDdkO/h2bGCSFIJTVDaaE3epcRD1IQXe2kkOMEgGEYZi
         12ZcCjDLhVoiW1GCW5+wfCwgVI80tC6lcFrvkZAifaIKj1KL9R2MNgVTlXlROv4UpToB
         B1AjsjgeSjD6nWEXzy5QvFGmzdqSU6n0tN8TAqqn05PJEJAv7/kEKcyW1VPNIta8sm+S
         nBlBkfebuv0873dJlS+UwJBzayQD4mDvg9qpSimRbN8h7Y5rgXfNoTZ3msem4JjLfD3g
         M6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075310; x=1724680110;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOKhhdkn+gAY40WJAVcjb3QkD6ROmre4iXdOzftmIW4=;
        b=m/UttCAn7/MWPXgrscson/9CyUm51leRz2Jfw/n22SBOyUq5CuKiJlaTlccdb5XWmy
         7w+fhxiSaypk2BHwObk6xfO2UXgNtZbPZasW0eSsd2fU2zeUCZ+ZWbIZSAlJPJUmshy1
         n1kYWwdrIKT5PgKL0mGXw81KIOBNzUafma3SG5QjfFsKIkokD5TXUssDk6ppBh1bzkRV
         xrdEmWARCUBRIcxSqaDQdkoVhAfiU0+Nj3puuzQI5OHniZVwZZy6idx/EX5MaNq7oFiN
         YCIeVr/U6AdAQMIS22HLnqOuA/YFIZ674WB0NT9tJk17H8vxk3Y6NGQ93ObQe5cdT3rP
         Bzvg==
X-Forwarded-Encrypted: i=1; AJvYcCVKZ8bOHZUMeIUlEQThRG8IwqEdM06z+axLWTSZ6QEGfoMPVCHWIIBIr2m6wC95nXS3py9ms1ZZS78IBsW8USTZBvkyiYKm
X-Gm-Message-State: AOJu0YyY7j+CYN5FguSCzdQ0b5Srwjj/mUQc24IcFRSGffL9UShKXBkO
	sGAqLb0VZh0BP+Cv8hO0QZ4Ayup6xmyH53C1Cu86wrirDtvzloXB3BlJDXUdl1TzJbhCih2UFuY
	xpkfW6MBJIQ==
X-Google-Smtp-Source: AGHT+IE74BwdzFWnsjOa7aJFcDJ7puwe0JeqakjHmbYy0bigKfAe0lV0pPDwedrunqcX22vKdniinrCW7CdgAw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:6084:b0:620:32ea:e1d4 with SMTP
 id 00721157ae682-6b1ce2e2672mr8370217b3.0.1724075310135; Mon, 19 Aug 2024
 06:48:30 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:48:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819134827.2989452-1-edumazet@google.com>
Subject: [PATCH net 0/3] ipv6: fix possible UAF in output paths
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch fixes an issue spotted by syzbot, and the two
other patches fix error paths after skb_expand_head()
adoption.

Eric Dumazet (3):
  ipv6: prevent UAF in ip6_send_skb()
  ipv6: fix possible UAF in ip6_finish_output2()
  ipv6: prevent possible UAF in ip6_xmit()

 net/ipv6/ip6_output.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.46.0.184.g6999bdac58-goog


