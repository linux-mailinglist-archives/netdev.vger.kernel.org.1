Return-Path: <netdev+bounces-122453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1540E961647
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED4D287AA2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1651D3621;
	Tue, 27 Aug 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH2Xmboh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAB1D3622
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781801; cv=none; b=JmBOMSozV7sY9Gaao+32cw9J+jeri2ZTLjjwAzQ0lgu4gNgkiS6h0GD00tAiiLkd76Y3N2riqpBJAdOMcUy79LlBR3fCEECve3Yuad/THV6eNKjzWQSBmYIFhMZ0AfWgiGxdyq4CjBmqxKlDEepq5ckavPiuCMPa4eu90Q8GW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781801; c=relaxed/simple;
	bh=EVl9XmBEGraFkDRmYKHcPjDfOyqLOV5AlkZhIsyCRFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQZ4QNXNKY9CfOOnRBWnKY9cHapHImVPN+H5WE+HtZaLaptRsAd8Evf4Wf9cdywmw0Dz6itQVHKjqfhOlrv8w8UwOsyFLKtdlDBVsrQKc9K7rAHMC4oJDOeuUR1aKPHU7+6nQhS9+t/iTEntHXJ10Jr/KQxt/wAxxNv+ONtu3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH2Xmboh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724781798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdJBi9yY/9Wqn0S5jG8EeDv8lkEIJtCuMq5NHG08cG8=;
	b=FH2XmbohWdgTHpmnlZ4DU10m8HztzkmuU7aj+rkYJIZo/0ekyKsD79EzsTnYIjpwCNQpx5
	8NqC09xOZSFMT8AZg6AzKk5U1WNZ4wwC9rLKOxtJKE3ktXhCzSmiai7uhP6Y/p/g7yZb7K
	Cv9FyyQ2O6sRpNZDajN3BH8VR6JARHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-qBmchWQzOR6rjT6349ZJ2A-1; Tue,
 27 Aug 2024 14:03:14 -0400
X-MC-Unique: qBmchWQzOR6rjT6349ZJ2A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD06C19560B1;
	Tue, 27 Aug 2024 18:03:10 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B81A1955DD6;
	Tue, 27 Aug 2024 18:03:07 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	netdev@vger.kernel.org,
	vvidic@valentin-vidic.from.hr,
	heming.zhao@suse.com,
	lucien.xin@gmail.com,
	paulmck@kernel.org,
	rcu@vger.kernel.org,
	juri.lelli@redhat.com,
	williams@redhat.com,
	aahringo@redhat.com
Subject: [RFC 3/7] dlm: make add_to_waiters() that is can't fail
Date: Tue, 27 Aug 2024 14:02:32 -0400
Message-ID: <20240827180236.316946-4-aahringo@redhat.com>
In-Reply-To: <20240827180236.316946-1-aahringo@redhat.com>
References: <20240827180236.316946-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

If add_to_waiters() fails we have a problem because the previous called
functions such as validate_lock_args() or validate_unlock_args() sets
specific lkb values that are set for a request, there exists no way back
to revert those changes. When there is a pending lock request the
original request arguments will be overwritten with unknown
consequences.

The good news are that I believe those cases that we fail in
add_to_waiters() can't happen or very unlikely to happen (only if the DLM
user does stupid API things), but if so we have the above mentioned
problem.

There are two conditions that will be removed here. The first one is the
-EINVAL case which contains is_overlap_unlock() or (is_overlap_cancel()
and mstype == DLM_MSG_CANCEL).

The is_overlap_unlock() is missing for the normal UNLOCK case which is
moved to validate_unlock_args(). The is_overlap_cancel() already happens
in validate_unlock_args() when DLM_LKF_CANCEL is set. In case of
validate_lock_args() we check on is_overlap() when it is not a new request,
on a new request the lkb is always new and does not have those values set.

The -EBUSY check can't happen in case as for non new lock requests (when
DLM_LKF_CONVERT is set) we already check in validate_lock_args() for
lkb_wait_type and is_overlap(). Then there is only
validate_unlock_args() that will never hit the default case because
dlm_unlock() will produce DLM_MSG_UNLOCK and DLM_MSG_CANCEL messages.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 43 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 121d2976986b..8cb5a537bfd3 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1703,19 +1703,11 @@ static int msg_reply_type(int mstype)
 /* add/remove lkb from global waiters list of lkb's waiting for
    a reply from a remote node */
 
-static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
+static void add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 {
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
-	int error = 0;
 
 	spin_lock_bh(&ls->ls_waiters_lock);
-
-	if (is_overlap_unlock(lkb) ||
-	    (is_overlap_cancel(lkb) && (mstype == DLM_MSG_CANCEL))) {
-		error = -EINVAL;
-		goto out;
-	}
-
 	if (lkb->lkb_wait_type || is_overlap_cancel(lkb)) {
 		switch (mstype) {
 		case DLM_MSG_UNLOCK:
@@ -1725,7 +1717,11 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 			set_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
 			break;
 		default:
-			error = -EBUSY;
+			/* should never happen as validate_lock_args() checks
+			 * on lkb_wait_type and validate_unlock_args() only
+			 * creates UNLOCK or CANCEL messages.
+			 */
+			WARN_ON_ONCE(1);
 			goto out;
 		}
 		lkb->lkb_wait_count++;
@@ -1747,12 +1743,7 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 	hold_lkb(lkb);
 	list_add(&lkb->lkb_wait_reply, &ls->ls_waiters);
  out:
-	if (error)
-		log_error(ls, "addwait error %x %d flags %x %d %d %s",
-			  lkb->lkb_id, error, dlm_iflags_val(lkb), mstype,
-			  lkb->lkb_wait_type, lkb->lkb_resource->res_name);
 	spin_unlock_bh(&ls->ls_waiters_lock);
-	return error;
 }
 
 /* We clear the RESEND flag because we might be taking an lkb off the waiters
@@ -2926,13 +2917,16 @@ static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
 		goto out;
 	}
 
+	if (is_overlap_unlock(lkb))
+		goto out;
+
 	/* cancel not allowed with another cancel/unlock in progress */
 
 	if (args->flags & DLM_LKF_CANCEL) {
 		if (lkb->lkb_exflags & DLM_LKF_CANCEL)
 			goto out;
 
-		if (is_overlap(lkb))
+		if (is_overlap_cancel(lkb))
 			goto out;
 
 		if (test_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags)) {
@@ -2970,9 +2964,6 @@ static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
 		if (lkb->lkb_exflags & DLM_LKF_FORCEUNLOCK)
 			goto out;
 
-		if (is_overlap_unlock(lkb))
-			goto out;
-
 		if (test_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags)) {
 			set_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
 			rv = -EBUSY;
@@ -3608,10 +3599,7 @@ static int send_common(struct dlm_rsb *r, struct dlm_lkb *lkb, int mstype)
 
 	to_nodeid = r->res_nodeid;
 
-	error = add_to_waiters(lkb, mstype, to_nodeid);
-	if (error)
-		return error;
-
+	add_to_waiters(lkb, mstype, to_nodeid);
 	error = create_message(r, lkb, to_nodeid, mstype, &ms, &mh);
 	if (error)
 		goto fail;
@@ -3714,10 +3702,7 @@ static int send_lookup(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 	to_nodeid = dlm_dir_nodeid(r);
 
-	error = add_to_waiters(lkb, DLM_MSG_LOOKUP, to_nodeid);
-	if (error)
-		return error;
-
+	add_to_waiters(lkb, DLM_MSG_LOOKUP, to_nodeid);
 	error = create_message(r, NULL, to_nodeid, DLM_MSG_LOOKUP, &ms, &mh);
 	if (error)
 		goto fail;
@@ -6342,8 +6327,8 @@ int dlm_debug_add_lkb_to_waiters(struct dlm_ls *ls, uint32_t lkb_id,
 	if (error)
 		return error;
 
-	error = add_to_waiters(lkb, mstype, to_nodeid);
+	add_to_waiters(lkb, mstype, to_nodeid);
 	dlm_put_lkb(lkb);
-	return error;
+	return 0;
 }
 
-- 
2.43.0


