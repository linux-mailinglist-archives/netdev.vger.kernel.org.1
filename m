Return-Path: <netdev+bounces-189418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208EFAB2082
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 02:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B8A7AD652
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A752F99;
	Sat, 10 May 2025 00:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C6CA6F;
	Sat, 10 May 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746837297; cv=none; b=Kw/9LUNGS87WHEbE23YbxEASwG/HCvtUW+z44m8BYUrnh6nw370QnJaWx6AZ8Rg3SAA+FXcQfM3IWR/tHkww9WTHilsyXWs1X7aozSwWam0pCc1Y17JKKBbsFK5U3nDoVIuyNhkFyirnfnHWsnoAIV0hpENAy1GKbKBY0fp645U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746837297; c=relaxed/simple;
	bh=iUKIhwoRMiye51Xwv0gCRSu5tX42w2M3ND0fwVhJi0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz6mZ6dSqQZW3iyRwIUtjWGEP0HgHipZFJ8dmn/23L1pt3nTVAm29e9CVK6SqVtHqODJs5mbN/6vGN+Rp+LeCvHVloUeR+wdHxzCezSmP5oizz5I7/BG4/KEazlwI0QWjsqmQOcErwhlwLmZKkpOAhQG49GyZpTHN++YNX6/sHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uDYAw-0002EB-2N; Sat, 10 May 2025 00:34:46 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>,
	Lee Trager <lee@trager.us>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/5] pldmfw: Don't require send_package_data or send_component_table to be defined
Date: Fri,  9 May 2025 17:21:13 -0700
Message-ID: <20250510002851.3247880-2-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250510002851.3247880-1-lee@trager.us>
References: <20250510002851.3247880-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all drivers require send_package_data or send_component_table when
updating firmware. Instead of forcing drivers to implement a stub allow
these functions to go undefined.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 lib/pldmfw/pldmfw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 6264e2013f25..b45ceb725780 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -728,6 +728,9 @@ pldm_send_package_data(struct pldmfw_priv *data)
 	struct pldmfw_record *record = data->matching_record;
 	const struct pldmfw_ops *ops = data->context->ops;

+	if (!ops->send_package_data)
+		return 0;
+
 	return ops->send_package_data(data->context, record->package_data,
 				      record->package_data_len);
 }
@@ -755,6 +758,9 @@ pldm_send_component_tables(struct pldmfw_priv *data)
 		if (!test_bit(index, bitmap))
 			continue;

+		if (!data->context->ops->send_component_table)
+			continue;
+
 		/* determine whether this is the start, middle, end, or both
 		 * the start and end of the component tables
 		 */
--
2.47.1

