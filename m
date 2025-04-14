Return-Path: <netdev+bounces-182211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD7BA881D0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F8E3B796C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174292472A6;
	Mon, 14 Apr 2025 13:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D224728A;
	Mon, 14 Apr 2025 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637086; cv=none; b=I2R3aG93DG6X0sK97cKqnKjzE/DByyJ72mm6pZzi6ffnG8GDpYa7rzwIM/+a6A2mSRUZmcsfLR460lHUD6olNm0jqoj8FdfcbiOtrrZ04yqI5pi8e4Kh96H4C47O3Kp6/36ga/nim3BCxFlFR2/ht5DjMCBDCFTwAC3wKNoQ2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637086; c=relaxed/simple;
	bh=syD955WpSQtLuG54Xzxtf7ya+/0Ya5JyfmNpAaFGX9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDWUV9OWOdnzE1cL1oQBJzMlCFSV40EZvn0dfsmZky/PB/rHotCJcMo42s4qGz2OQnjdK3dogxygALD983TdHF7gKYV2Wm069GfDICHCu/+21x89KHT0ghRZJSeOMVK45z8uUcwm4wfofWGSc/whCFGuNgKpiMsLSAummPlQoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so669011466b.0;
        Mon, 14 Apr 2025 06:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637080; x=1745241880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/q8ZQro2xxVA/d57oIv17tdTCVpCAiyXmf3ekOjhnU=;
        b=ILkVTLXNPCWw+74mUJ25SxUtCr9SyQqfKi8LVRLf2F22v1Hslm4bLdS4W8aMaO6vZ5
         MG+dRK+ZSg5+zNvz3RFktRFi9ldDgdenHXnAHQ8vczNv51fuH1nS68hEUNB1MXZFU6Tv
         2w/7AMimkMQ+2hhDb1Yyrxd9T7kzXxUJDj6v1bpz3aoWV5i8NmcP65fV6g7LTQNbtg+l
         v1k5MH2hA+W35H34C4XP2Biv+Qyu2AjXbTDPb/4eVMqkcVfCp/I6BFvA04FVL6UVm6kM
         TcMY6PhPdpYZh9XrBLvdsSUW8/Lxj3smNUvc3l02/9H6qdl23JsKCWQGrhGlWtwuvzdT
         gGYw==
X-Forwarded-Encrypted: i=1; AJvYcCX/5S+tCFXGrCskt0XIpdc/md6oHxihkPKwjksSV3uHJmRdraynm08g3YLSTA9iA/jnm/EwvfConL3vIYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuPecsuFa8eLP4o6WjgeCr98Mjf0CCSCoITXTmGC2rXVHPP2vb
	ch4dNCSbjbojAk+t9s6EGFjM/A7FWlHX7MkbIEr4ffSVK/cps07U
X-Gm-Gg: ASbGnculVUhLWazA/r0tnIBNohlzoKWFXBXgFlBlU/soVC2fy24z6CvDWbCBdqv69cu
	AoOR2dXJgIEUwgX/KWV4oqFhvfhlfy/JPv0rYROI+HaIvTOXs759nWF+edEuXE9OQ+PDOC+oGPs
	6EWd7bdv3Nhjb78cDEU2ds7B+8CoKqo6oy28vT9KBnbWxt+hVJsWdD0q8ygzn6aJ7360G8jNcQl
	7Q72aZjPbgTuGFTSH07c16NAn71JYsCQlLZb44qTQe+kA69/FeGJ8wetfmaSMMyxQz6bpvUwvlt
	HJ0KWVaV12U6X4moyfgbB+UP2m+aX8w=
X-Google-Smtp-Source: AGHT+IHnFQH2kjPj2LpTKkQ1WQ4QWUdeJGMxJ+16QBGzybRMOnKQgXbeQIaHesXZWmxH7/0CMKxlPg==
X-Received: by 2002:a17:907:cd0e:b0:ac7:75b0:67d9 with SMTP id a640c23a62f3a-acad342ec56mr1161256966b.4.1744637079783;
        Mon, 14 Apr 2025 06:24:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f06c4fcsm4995592a12.47.2025.04.14.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:11 -0700
Subject: [PATCH net-next v2 05/10] mpls: Use nlmsg_payload in
 mpls_valid_fib_dump_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-5-3d90cb42c6af@debian.org>
References: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
In-Reply-To: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=leitao@debian.org;
 h=from:subject:message-id; bh=syD955WpSQtLuG54Xzxtf7ya+/0Ya5JyfmNpAaFGX9Q=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyOP473aRGHCLVkYDPdkgDInL+wKxYo8dVF6
 GmYODT7BsuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 bVXND/9UfyYpGcxw4CSwESTsLKvD6jEaBgmVfXfz05uaFmcbXqRdvkNLeBmvYA6qOBBybGKcS/9
 deA+j9QAwUdHHztBg2SwtWoTCIvw1djGzSZaRvcGg/YmDbUoXN91AjLCDZdibZ7BJLQ5HaTt3JU
 HcQg6tn71TpvcCTspA58evCpNqqBm9rHq8FFFLLYqE0B8td9iMJUlOJwlBm6AGJxJWmeiYCsLiK
 puSrSkNeAK0ic/jvSXEC4mf5SmwNCySng3frTglfO2dOjX47qVqZ0muuuFM4z7GctKRolqQL3cf
 BGYauEwDh7OxhfA8A5/NjhoSUW0hkpHEvOKmPgKB5zyP1otOJhu8Mdf8oSfH0599RQqkq9winnG
 fskJcrASf90XW0TE/4SbdvCWCIDowgWEnRfZiAT2c/jUF0Owng+WGNV5baTekL7PUPl2biJy4gu
 QZwRYrv4uhQDp3sH0JcdnrOUi1dGIDpOLrpHI8OZ004nG2C9zFhglvb554ZA8h1uyM5PwqqeOeZ
 dxny9h10m8zjVa/HsbauVgsolHE2vXcafccoDc5SzRt7BiiEGxAO4OQSwh4nzaKDD4rkA18Vmmi
 q/cZ5arVsVPO96LmK8GTM2N1Cxe5H4iFiGADgYia87CjNpgfrDwIFnz5irrMgcOH1KcJDZhVV7w
 eE7mnVw8cQhHMHg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/mpls/af_mpls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 1f63b32d76d67..bf7cd290c2369 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2095,12 +2095,12 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 	struct rtmsg *rtm;
 	int err, i;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*rtm))) {
+	rtm = nlmsg_payload(nlh, sizeof(*rtm));
+	if (!rtm) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid header for FIB dump request");
 		return -EINVAL;
 	}
 
-	rtm = nlmsg_data(nlh);
 	if (rtm->rtm_dst_len || rtm->rtm_src_len  || rtm->rtm_tos   ||
 	    rtm->rtm_table   || rtm->rtm_scope    || rtm->rtm_type  ||
 	    rtm->rtm_flags) {

-- 
2.47.1


