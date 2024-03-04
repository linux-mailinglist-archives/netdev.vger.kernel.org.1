Return-Path: <netdev+bounces-77079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E6870132
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE88282D37
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1DD3C6AB;
	Mon,  4 Mar 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beYtoPfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1CB3C6A4
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555242; cv=none; b=Nb43viZ5ZFpw+BbyjtyHeGdPOgjA/KVrwE8H/f+FIsyrspJwGexEMQCveuIBexv++3iEZh+9Cht18IUR66s6HQC44lV4VNbMZtxBxUadXFvJSEjq9S7mZFPl3BtYR+EBGOIc8WhDzDSDz2oHhopkOok7UeJfm/dbcx8qOcAchLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555242; c=relaxed/simple;
	bh=RZfUjVj2KwyANj/kshaPoFzbJnolmbo0UmQei0RPnlI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FsWnqtjLDL0FTaOdT/XHld+rgYhVLGgHGlC4KMgI5CEKAdwSD23hQcgfoqce3IGd7cCtAruReqYl3y8sFY3uOgZavKgB1hyaE8tueASzqkkG4ku4UCICQpJW78IVgzcRtZ+xxIKOmwCMNgqwckg30N/zdilm6VoH3ZdQ2memhwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=beYtoPfa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dbc6ff68ffso55574985ad.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 04:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709555240; x=1710160040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X/vsxqb612cf7MH6SU+N2pUH4K+d5PGn0Hr8kIYgZyM=;
        b=beYtoPfam7UOJTq1pEsLWArnEcpVVsjjC/SMdUQQAPoHyF2wUZ5AkitnQAd6Yw/oYE
         iNSYCIyJYw94HlrtG48OWt+9Kh5fKVK5FTGujg4yF9M0Glttdv4GPC/CLeIpt8VvYJy1
         dVLi9b0FwNQ1zHcxKN6cyCJVUb7b4qYKEO3f8tDoZEyOw0qnh7rfNrpwBW350HZw70x2
         649nGZXJasKuzzjQFE32DZV3Ol1xdkWtUZK9j4+r+CM974DaTR+5WLZzhafegfuP8KFA
         T8vl+mY8j/fezHvT0R11+Zo/R6BnfA/lSOigGIw2Se2yvzAxO4QmJTjaNEn5HNnQlP7P
         kdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709555240; x=1710160040;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/vsxqb612cf7MH6SU+N2pUH4K+d5PGn0Hr8kIYgZyM=;
        b=k3i8tKwlAMANHwmYrOOH4lHERqX5I9d4GVrG5YPmAWiXiHz+4ac9IRh2M1JL4nn4mx
         ybQycFlXvVxbraPWLlht+ISLDy4cUOzdvXHpMHfWtFh75aE1QAH4u8CEgEjwPNFlUuUE
         bixEpJgPQy62O8SYEu4Da+/tDB7bj7iRDuDQkd3VNZGYwddr8AA/fbXn7rU5GMyWxc80
         /jJW7oy55Ku+BpaJ8fXeGkZ/YnP0Ejuo44EZzYeXRA+7Mf/3aPcZrgIIoS8wsMRyJABh
         oKXujW0Nc6fNUEpfxMxcsU+evXgVUE/LHUzStuozmwIUU8lyUJErqGQOSLrURtrqolLH
         fAgA==
X-Gm-Message-State: AOJu0YxgB+BVQUFVYmRqsrdMv5OnlX+GJCUcAt4tu96v6uw3ZlkyZrca
	WwTTzOYtXfnzfJAK4YSu1T1yJ75OxDRyTxSjh5ughr/Oj4HIHC0+OMpr5n8lQ7xRpURxqMsCVZT
	wki4umYDIVXMdzwe4De7FMQiQwT6R7UFLI8QXB6LMSFtJp4eme6/98z7oD+xhaCwPWvkEA1XD7/
	tVldfDKhB8nNQMEP9pw1b7soYL8+g7Pofn
X-Google-Smtp-Source: AGHT+IGOwkZjEBZJtMELxmHrjnGpQ6A4lyCKsHuWkAYtnrX/IhhipEfOQ5xaaVyZH0L5Yt6ercXVgTVQMaA=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a17:902:e551:b0:1db:d6a8:d487 with SMTP id
 n17-20020a170902e55100b001dbd6a8d487mr989830plf.13.1709555240556; Mon, 04 Mar
 2024 04:27:20 -0800 (PST)
Date: Mon,  4 Mar 2024 12:24:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240304122409.355875-1-yumike@google.com>
Subject: [PATCH ipsec 0/2] Improve packet offload for dual stack
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
Content-Type: text/plain; charset="UTF-8"

In the XFRM stack, whether a packet is forwarded to the IPv4
or IPv6 stack depends on the family field of the matched SA.
This does not completely work for IPsec packet offload in some
scenario, for example, sending an IPv6 packet that will be
encrypted and encapsulated as an IPv4 packet in HW.

Here are the patches to make IPsec packet offload work on the
mentioned scenario.

Mike Yu (2):
  xfrm: fix xfrm child route lookup for packet offload
  xfrm: set skb control buffer based on packet offload as well

 net/xfrm/xfrm_output.c | 6 +++++-
 net/xfrm/xfrm_policy.c | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


