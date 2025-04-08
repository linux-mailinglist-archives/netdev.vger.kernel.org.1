Return-Path: <netdev+bounces-180243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDB1A80CA5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F0C3A570F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA9145B24;
	Tue,  8 Apr 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrp+i+p8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F1EADC;
	Tue,  8 Apr 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119413; cv=none; b=T05oJELI3cQ+vOQfR8heG8ZMwTErtP2gSkv5/g+T/5LLTN8IWVwAWjV0qFcDkj67EMzNWZwcH61/cObzOmqmQ3u5JT47uh7v9BQmceNTwRv9e2Oc7LW1FMMrjM33LHkbF0OqgTbhjTUeykJfDaCpKKVkwjE1+DhhYXXjlP8ejzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119413; c=relaxed/simple;
	bh=/Mww6HGkwfJikQmES5LVya/rHnb3UTVGVbFYY5W3MCs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J/4p9ZZqGs2nGNws+BVKv8lEK4dnU4fG5Rh8UAp7rDacjsDJhzR7DM1mX9QYzceJ8RNUVEBprHTu4vNLUmma69zi/suXgkTJb0aKWilwmwg4M+T2YS8LlxKROL2+ToWubn5ksS6V88MB0cdeWN4hUVwFSwBDRycTzySgWjCTCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrp+i+p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB866C4CEE7;
	Tue,  8 Apr 2025 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744119412;
	bh=/Mww6HGkwfJikQmES5LVya/rHnb3UTVGVbFYY5W3MCs=;
	h=From:Subject:Date:To:Cc:From;
	b=qrp+i+p8Nf7aeP60zT18AneAD8X2tXFksZRNBU/kcYkui+sQ1SOhmw6GByrZpaE0f
	 L8lEP2Qj5JzvH0v5YjlHPavu12DNguvD4hfSLPClb/4BTBcJB2q10suqA5AQ/S8jRS
	 P8hML1sFKdFKvbzewZfNFuseV5yfBx09LqQyOtDmu2TUnLrVB2S3pTGwzGcZCaybwG
	 k/UXy3KInTR2Tc4MXohsIWuNYwGJ5By+kKdjpX45l0v947fmBSSIgXEfITIJwuVii6
	 02J/TQpOodAXla3eUNibYnrutokY0kdNllV522hfgN7/EErR8XroQCuCA3KSqIMQWe
	 34ij8hUtCLf3w==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] net: add debugfs files for showing netns refcount
 tracking info
Date: Tue, 08 Apr 2025 09:36:36 -0400
Message-Id: <20250408-netns-debugfs-v2-0-ca267f51461e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQm9WcC/3WMyw7CIBBFf6WZtZgyFUxd+R+mCx4DJRpqoBJNw
 7+L3bu6OTc5Z4NMKVCGS7dBohJyWGIDPHRgZhU9sWAbA/Yo+gFPLNIaM7OkX961dcgHjUqPhqA
 5z0QuvPfebWo8h7wu6bPnC/+9/0qFM87MWdBohZIo5fVOKdLjuCQPU631C/87HuerAAAA
X-Change-ID: 20250324-netns-debugfs-df213b2ab9ce
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/Mww6HGkwfJikQmES5LVya/rHnb3UTVGVbFYY5W3MCs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9SZy+c3bNSQ6jrUyTHB3UW3L4gImzHL6vSGUn
 a4Vh4YNAHeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/UmcgAKCRAADmhBGVaC
 FSKgD/0aXYJoQYJOwh+m6TIVMNh/TnGNBm+NCWL1nKXybF7AHovzlUhijg73WSvLhpMLoWjnUSd
 Ra+mEKEtkRna0Rd65VGm4SjoXNm+sw7720DUX0A2c7hw98Gsxmy9SS/sgOIxH8ot6JYQIKCjJ7z
 NswWvC634Jfr9kNtZymhh2jp2n7qtNawJT4YgsWH93DIRVyGDerygPk5+8/sQOval0UNF5auZvT
 ywRIMEhua6ltty8m6FCZmTl9hWcnFKGWdOPiuLAd29xsiXd14WWgmSZBqGpvZaRER0OFk0gEaw9
 9cF0dsHsUAAGKmI+vAsth0J7jqkOPfkbojAUvxMouga7l+xU9COwPPeLuJReTnAAc3URV27me2+
 doyE7dVzRi1tvP9D++PbkS3fZCrhIBLHACYmhKqHim9Hokw1NZ1b8RQmB3JICbUTe7K1d0wIsYc
 1tV+A8LKRhY/8WkluwjQ7JH7KxnBCplrooiZq/XWcMIqUb8NeFAq0mk3znd6VZBsymmfK/7a7PQ
 LqgBdJfB30FJuV+mY7/VyJgT4krrcqHJTLkA1NxujJXCcHGTFBtF/8kkI+IWxpJhCum2WHQZOrK
 +/0qyI3jcHFvH81rImHK+jX14HWw7WsVPZ0/EuTWtg7yuM1uj7qI0stqMMK7ZlccfZGGfoeCsnp
 X1xnedagXywCLSQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Recently, I had a need to track down some long-held netns references,
and discovered CONFIG_NET_NS_REFCNT_TRACKER. The main thing that seemed
to be missing from it though is a simple way to view the currently held
references on the netns. This adds files in debugfs for this.

Eric, I didn't incorporate your proposed patch to limit how long this
code spends in ref_tracker_dir_snprint(), as it didn't apply properly.
If you send that as a formal patch, or point me at a branch to base this
on, I can rebase this series on top.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- add top-level ref_tracker directory in debugfs, and move net_ns directory under it
- Link to v1: https://lore.kernel.org/r/20250324-netns-debugfs-v1-1-c75e9d5a6266@kernel.org

---
Jeff Layton (2):
      ref_tracker: add a top level debugfs directory for ref_tracker
      net: add debugfs files for showing netns refcount tracking info

 include/linux/ref_tracker.h |   3 +
 lib/ref_tracker.c           |  15 +++++
 net/core/net_namespace.c    | 151 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
---
base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
change-id: 20250324-netns-debugfs-df213b2ab9ce

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


