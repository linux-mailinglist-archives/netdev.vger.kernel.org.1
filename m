Return-Path: <netdev+bounces-287586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEvQHa50BGprIQIAu9opvQ
	(envelope-from <netdev+bounces-287586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:55:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0314533667
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63EA9313CDB6
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E742668B;
	Wed, 13 May 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFj9pDNY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FD40DFBE
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676443; cv=none; b=D2izvV8HcIqKD+bU/d7omd3HEuNY9KlfU/i4cLcHEOfdp4w0VRT+etRUyPpGe2vWykGp/wdSdDsacKHxMx1E3q1OBfXPIXCqNOIOm1hOVyRs0sqVuaEhTBuoqs6zRFdNqsuDeDAr6+TqEqrM8dCZX6UGf16x1qadzchGobkoYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676443; c=relaxed/simple;
	bh=zJ8Qime73j4wDWVjXuqgGqErAVXbH9TI65O2PqxtGYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGyCjPlqiK2ancII1br2GvgXeM1IM8KpXDtWfl9bpl/kRH5geQyZ0H+/FCq6smj74DRy7vRutPfSMTUntSo3yU0707VQPW2LTtTupUFC2IIr2wnXBbEUtnIpY5bcirjEHVWTrQz8Uu7nC9G+cH1tBpa8b8fojf76zzNrvgFYU10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFj9pDNY; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbd23bc684so3789558a34.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778676441; x=1779281241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ8Qime73j4wDWVjXuqgGqErAVXbH9TI65O2PqxtGYM=;
        b=IFj9pDNY5vmQTnGF9q2xxmjGQ3Js1aM+/D3bpqD+Xe/DpLHPre19KhSqVXsTsnGsmQ
         vXfbvyrnsWhiTQeBDIkUbUfdMNy9ghUd5ftRs/mhx1MM0pYbofHnIHdOLaSVUfXQJ2Is
         6mhktWkQwnG3W1s+dfGhWFhnVw6ux4K1k2ivlq/PdAKi0AoUt2qR+lwV3c8107muRss1
         2jgRLhMv0XTBXQLn0oVc6hcgPYUqTIndGWdIHZE3/qbHkUjOFT2VhzR9bYSUNH+h7vk3
         9K3v5Hbg2vl0nhDeBFae3YtNOIrKl++K0MkmX1bIKYcEqAv/ZGCBpd1QiY74oZBIbbM2
         PHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676441; x=1779281241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJ8Qime73j4wDWVjXuqgGqErAVXbH9TI65O2PqxtGYM=;
        b=psLtYF6zmEpq2sasaatftCxdhcePibfvjVvqQdHCEmZfYPobVAoqnZf/UC2Z+8WlHa
         Uzyo3FFLVbxMP4OCgnQsQwhMYXJM3c5sDGx0/LKh85VlNkI1Z9WsUVasD3S6W3AMkrQq
         ZhEZGXl55ANJzW1IQLf4Z+InN7k7qBdRefJR8DleNEehUUnMZaer+3EO2d5uROqXneB/
         ZVb8S43S+IR9eV0OwlgXJoKnpSFMSJ/HtYfXUpQ2nGpgMEhHYjLhFVn0OL2HvJ5eX94p
         HTOuWUo3bfg0QHhk68VrAF2oTwXFv8PMC/zPNAbk0IFQZxdPW5r7srDUFB9uHmZb+/sj
         nwsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XUvCNgdBF68zASvthWlcKZ6mSs0CmRADFzfbtrovW3Rg5NbsKTgL6L+FqsgUds5uM6XB//f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzag2Tp0GNzf1jj7GCR28jA7/PFGMuuK1xpZzR6bOKAhzShGyeS
	1OFcpXCxw95Nk6zDOldYcvKcfS2W/1Csch8ZLr+I/s1NqJt+/HIs5MzL
X-Gm-Gg: Acq92OFKNLXrZC73Dmpe3Fqy+RjKhRbGsIa3VyHTEDgc/3itczJlACEmeOMG7aRJWhZ
	OWiaGxFWpLtQKFzO75igr+72Z+7mgjhH/5qvQv3Ryop/VCiBpy51GxTtX3qo6oqk7uKxYvGbYrU
	s3gCt0O6HFGLWk/rEhGbgIWq8O8brKHyAU5rk0kqwNe8JS4xWUC0NKhVMW5lra8EOXriAk9q70s
	xcGaf38TA1rJGhbgbwsyyOGzKYQ70FjeOjnkLc4NVEubKGfw77i1T6fgAozLMB7regeWsbfLRqo
	grWU1ljftw0D9t+XUZD/YN1s+bueJYpbL3jp7HPx/O48CTYCYQrH2pdWRjNEGGjAwUKxtv2U0GJ
	sEJ8S0gMHNda+gxmsMuY3uBFGkGMlAtIl5KiaeEVxgviNE6rcnFvzmRu92UhzgwpF+WH38yeTaR
	IAzRBy9j2qGUc2UO8=
X-Received: by 2002:a05:6830:43a2:b0:7e1:cba6:9838 with SMTP id 46e09a7af769-7e3da0cd60bmr1869736a34.9.1778676441087;
        Wed, 13 May 2026 05:47:21 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d90148sm11350486a34.20.2026.05.13.05.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:47:20 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: Aaron Conole <aconole@redhat.com>
Cc: Minxi Hou <houminxi@gmail.com>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	i.maximets@ovn.org,
	i.maximets@redhat.com
Subject: Re: [PATCH net-next 0/5] selftests: openvswitch: pylint cleanup for ovs-dpctl.py
Date: Wed, 13 May 2026 20:47:04 +0800
Message-ID: <20260513124704.2610072-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513121240.2590767-1-houminxi@gmail.com>
References: <20260513121240.2590767-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C0314533667
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287586-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,openvswitch.org,ovn.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Aaron,

This series depends on the v10 vlan/pop_vlan series (still in New state):
https://patchwork.kernel.org/project/netdevbpf/list/?series=1093324

Patchwork flagged apply failure because v10 isn't in the tree yet.

Should I wait for v10 to land and resend, or is there a way to
indicate the dependency so maintainers can apply them in order?

Thanks,
Minxi

