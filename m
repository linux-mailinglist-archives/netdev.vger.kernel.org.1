Return-Path: <netdev+bounces-293859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IjsNTnIHWpPeQkAu9opvQ
	(envelope-from <netdev+bounces-293859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:58:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F89623986
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E278A3084303
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518343E1221;
	Mon,  1 Jun 2026 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+MI77sU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358031159C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336482; cv=none; b=OfZW0v6WAGCkl+D+zrH08jBvWPOxyG6a+HO4ahNNvUZvWxaA2glu5Ua4ykrQUziD2FiNrmldRiUOQqu6J4cg7MmHG1bbbxPu8FbaBIacpW3zZji28IT5JwFuffFz8pvJMGPcCobyEa2Ehu6e2g8GkXqk9Xp9Vgf3Rc4tQHcLRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336482; c=relaxed/simple;
	bh=frX3sXpRJ51vGJ1TZPRIiBeodbk5/mCzcr+R5H77Qe8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VXwcm6u/NXmOz9o2k01Jr4Lwcp6vqksX4FcqOm8IrMuIFo5IT/utWox+Hzfx/Zuu4O0fbdY5wfsoQI7MVMmJ6eVNdd3xvG7cgz+2OBHbv9SHtUlzEcd2BBIhoCkiLaN6MdNrK54+U3srdh3p1cbLTw9ACc6bGWr5CZNlmXGTy1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+MI77sU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8424aac207eso1268707b3a.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336479; x=1780941279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BPmqxKMufLM8AJUzCbDlebgQ1FTtR8jbwS8Xa0SDPL4=;
        b=o+MI77sUGGFSQ1X+U9wPIhSdjuXIY6/YxnWzAVd3QwYhcz7MTwv1pM5iC3iQ1HSham
         WBNN3qwym1e1XmZNWYVVZVI7z3j3JXx76k1+gIQHn1gwoPUiCVq295aMHo2kyMcrST3e
         Lw4BmI8KKSqK1nMJEmMBcpj7a1ME5qO+bzzAJPaml0cNx+38trM8Jp+PJ8t29ynMPDyw
         S9RGIqXtWERwT7ICbQyuRDOqqWer9rzk9qOM60PTAD2Wmuk74p4DinxCQ1PYFiX+VL8q
         VX8M/QMlCzNvNJwEe5TwhUUPVYKBH3uHkYG4f3rAHXh4A9CyMdUfGV0Swv6O871PZgZS
         AcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336479; x=1780941279;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPmqxKMufLM8AJUzCbDlebgQ1FTtR8jbwS8Xa0SDPL4=;
        b=PhoWRShUkJq/q9afb/F9jqwXa78QVzs87cRz7ncJI/6oXmZhtKg9rzFPkNh5ZQdTGA
         j9U8qKECKs2d8gpXXZo121XdEsMByGpeFYzXfb4c6hfemfKdX5VWp57AnVKOAYuNyizx
         W1k1zRZ9XwJw5xczkI2nHfqHOvwWBBmHSizAWsroVEtWh25v8Bz1sMgH/znffuV3FqFC
         aySCnzwO2kEwJR4dTuItBCx/cbpod5mQK6KUINaFjugxnf3DDieFjoegnDZ+JWeqRjsq
         CWwz3wEFgjVP6ZbqTvFsqfcT7d4yL7tMX6o93HmX+3hAOlE9zi833yqi1tgo577BcxAz
         u1TQ==
X-Gm-Message-State: AOJu0YwYbLSWsZTa7mxfXnjVWhNqqz+Rfk4iixgirWdf+4P4O1shOfw6
	XbFHc2BB190KY7vnTGGcNooMoAHXJNrR05fc7IN8YOSTJcCxogrNMr1LNX0f1EzevBbfCrG5QOf
	2Xt3cN6L3YOC26wFm5+23j6S/1oOzOZ2N3LqBDEcFT8L1we2V0aa+ojPe6p9xmYmKVdgcbmqlj5
	BgoOG7owD4MOnOOmHwjteDs9I/0umWfx9VhBFYfNqhE1Ql+1GfEEYVSpAmm7RoYqI=
X-Received: from pfbim20.prod.google.com ([2002:a05:6a00:8d94:b0:83f:64bd:2fb0])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:889:b0:83a:b344:826a with SMTP id d2e1a72fcca58-842254368efmr11155454b3a.26.1780336479231;
 Mon, 01 Jun 2026 10:54:39 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-1-hramamurthy@google.com>
Subject: [PATCH net-next 00/15] gve: AdminQ mode related refactors
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293859-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 39F89623986
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series is preparing the driver for the addition of a new control
plane mode(MailboxQ) by commonizing and reusing as much code as possible.
MailboxQ is a new control plane infrastructure which uses mailbox queues.
This is a new control plane to communicate with the device when the driver
is running on bare-metal instances as well as newer versions of the device.

This series contains 2 main changes to the gve driver's existing control
plane(AdminQ):
1) refactor some initialization/teardown path methods to make it work for
   both control planes.
2) add gve_ctrl_ops structure to the driver for various control plane
   operations

The refactors are mainly around the init, reset and recover paths so that
functionalities could be moved into the control ops like 'set_num_queues',
'set_num_ntfy_blks' etc.

This patch series only sets the control ops for AdminQ mode. This is
intended as a preparation for adding MailboxQ mode in upcoming series
which will add the new control plane infrastructure and then introduce
the corresponding control ops for MailboxQ mode.

The entire list of future patches can be found here for reference:
https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/

Harshitha Ramamurthy (9):
  gve: don't pass in unused parameter to gve_adminq_free
  gve: refactor initialization with helper functions
  gve: introduce gve_adminq_get_device_properties()
  gve: add a few helper functions to set device properties
  gve: add struct gve_device_info to hold device properties
  gve: introduce control plane operations structure
  gve: introduce ctrl ops to set vectors and Qs
  gve: refactor gve_init_priv for reset path
  gve: add ctrl ops to for queue operations

Joshua Washington (6):
  gve: simplify reset logic
  gve: add gve_ctrl_ops for gve initialization/teardown sequences
  gve: split up notify block allocation and setup paths
  gve: introduce new methods to handle IRQ doorbells
  gve: setup and teardown management interrupts
  gve: add link status/speed ctrl ops

 drivers/net/ethernet/google/gve/gve.h         |  91 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 459 +++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  25 +-
 drivers/net/ethernet/google/gve/gve_dqo.h     |   2 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 876 +++++++++---------
 6 files changed, 913 insertions(+), 545 deletions(-)

-- 
2.54.0.669.g59709faab0-goog


