Return-Path: <netdev+bounces-272863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD5oHRHayGl/rgUAu9opvQ
	(envelope-from <netdev+bounces-272863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 09:51:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C941C35127C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 09:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628AB300FC61
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A3F286D60;
	Sun, 29 Mar 2026 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJ9WVMZe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuwKnMET"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A027456
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774770702; cv=none; b=YZutWkNRaOC0T9znFFH4n0HbtguCOvW7WGgwcnwJ4TNKJ+OilyPnPQ1Na7YcsZtg1VtbRBvj60sHJOKSZOXajEjgdQiCORijqOqDYoTrfOBcKe2wzK8Zc1E5bMugbWyXaD1QqH37UdLDJo5KTDFBtxrYxOCwkFx8xQ4pQMkJlss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774770702; c=relaxed/simple;
	bh=0QqKeyJ0/F2jDnYJmXdz+VmqvKKDvNIttKKwHdq93AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W3gdxKZqgoL7/gHANUR9atIAi+fi/AzGxNoZkRX7OBJX/wNS4XtTixJU5yFLHsXtZ44O2jHmXFzB0Y2tFMBfpILIXWWGrJ4A9WhsAAzpM/xXfAWt+FSuTa9DdELdRpu11Q3vbY/axIcmnITryFTbRaDGJlSDtFRYxfpCmSYP/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJ9WVMZe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuwKnMET; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774770699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2g+8qZgdxqpIYeBdmB4OnaosPugCO2R3QxSlnsf14BA=;
	b=iJ9WVMZeGGZop5lA/5p4faYPR48U6ZdvrXrqBSQzXdwO55omecbfph5thU77k8fM8ky2zO
	kRTeppOBWGG/F4PupvZiA9Me7iUqCnO9fqWlKUBZxmA0Uqj7bAeINSrvK3dJw5DsyzY8BS
	EryGVhCVNKFRjYaGF8Qqui/7nOCJ/HA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-a63SrkQCNJCeSIBh0JaI8w-1; Sun, 29 Mar 2026 03:51:37 -0400
X-MC-Unique: a63SrkQCNJCeSIBh0JaI8w-1
X-Mimecast-MFC-AGG-ID: a63SrkQCNJCeSIBh0JaI8w_1774770696
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439ca4b3d0bso2044562f8f.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774770696; x=1775375496; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2g+8qZgdxqpIYeBdmB4OnaosPugCO2R3QxSlnsf14BA=;
        b=PuwKnMETCMRHi3mCx1FziBWdS4DswBinyqtxoJnF0OhqniSJ/oQrE52n/8BLfaZ5C0
         Ibefz9kVbdm8mjY/DjGpKGaRwebPArZlE34K/PyujUa+05iYzABTwA9rjrhQIBzc/c77
         WgKgyMEBvvwq1glRBq50wljtAo3fOBqJFLvCQEnLRHKDn/XC+3A4gE/q/d7iOeloFowX
         AJ4b+3JZqgjU1MyJqr5F166p5GwCYif6jnfIS1R9oS3A242zFvS/ELgf2uiMoC2hezdN
         VyoEP+dz7GIC23OoHSyQrZLLDUrY00ibuBE3eKEp4GXaRmsndS4R39aw7R4s8xx/syB9
         iw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774770696; x=1775375496;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2g+8qZgdxqpIYeBdmB4OnaosPugCO2R3QxSlnsf14BA=;
        b=P3zf3dMYk7cicwqnHjqO2w4AgaPZpl1oE2u7f9E//MpPA45gZg9QTu03FybCe1dT9w
         Ri/jFMD20Sbqa4/wXABfw9HOMo24Si0f6RHM1MH4BAx3VBJF3NI+M/je2pjd0KxVO31C
         tAxUPZV0uGZRvdocqn2GP4cWG7qA4UhH23UjutyUM3CU9vxnRkyZWLjrlhciva/lwWEf
         RAMgWu3RL2uMIG7MfiGFd0MTGcvJjDGB50TmLhyIOlBTjZq1gGAcSOOq5MdTmt5/Hu8o
         Eta0Jk9yvWZ2LTZFOLTufBjeUd33RXEkVcBt2D6QZrCb/y5wHtjpqFxH6iNb2M4tixo8
         /LmA==
X-Gm-Message-State: AOJu0YyRT1EmYKix4EH8/b/Y3IM7/TORDMX7/bIqZsDygJR2SvPNPYRm
	GTIRafcxkhzHnSuCCY3+wKnW4pbrbr+oV9nsGUBTYEIZX5qfK4BZM/GqEuuQUx5xHf+PnuQ37u1
	05HZg+2RdMwhVuBliVLzJ4UjheoF8ulskbVK0A7iM6LKs8JJH1P822jzeAgsgYgTw1w==
X-Gm-Gg: ATEYQzzNUMQMcN6B+u1D6XwT39wwnCsbcRH9HrqlOGWp4cV16HQNX369WhQSP0uFDQr
	yVTJzTn9Bx8O/ySFwvDevlpKbybysVV3B2o0l1yzLGJHj1HJ3976jtLZB9AGY+8tN4Yrjy9xd6d
	XqJmU70W2IQlIS7FgZQJs8tzpbe+QHpUAn71q9zq1T5h5VTM5euHx4MptPdwV1yTONTcGuXcYD2
	eOc9v98LO54//5mxaSmGune9k9KHPdmAVbnaNcAgghg0bT4/1jc27oQ4pvHxFoRQprW46RO1ZgV
	S8vczQLWPIGe3DEJZRi+sW/PTb3/3Sad62o3QHjU2sxclSOmAKooHEooOvgUAEY8NsuLdsHHv31
	ysCe46VzgJbmGxBa9SoZ1QYAx0UTnywgjiKPkbBbCIvS/l4FgW+y077OVxd/q5AFIVYNxN3E=
X-Received: by 2002:a05:6000:4013:b0:43b:60f7:2283 with SMTP id ffacd0b85a97d-43b9e9f6ae1mr13051246f8f.22.1774770695775;
        Sun, 29 Mar 2026 00:51:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4013:b0:43b:60f7:2283 with SMTP id ffacd0b85a97d-43b9e9f6ae1mr13051221f8f.22.1774770695291;
        Sun, 29 Mar 2026 00:51:35 -0700 (PDT)
Received: from [127.0.0.1] (IGLD-80-230-124-201.inter.net.il. [80.230.124.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e2487sm10369771f8f.5.2026.03.29.00.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:51:34 -0700 (PDT)
From: Vitaly Grinberg <vgrinber@redhat.com>
Date: Sun, 29 Mar 2026 10:51:01 +0300
Subject: [PATCH iproute2-next v2] dpll: Send object per event in JSON
 monitor mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-dpll-mon-j-v2-1-c8170a80e6d8@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OzQ6CMBCEX8Xs2TVQEKsn38Nw6M9iS6AlbSEYw
 rsLePU4M5lvZoFIwVKEx2mBQJON1rtNsPMJlBHuTWj1poFlrMoKxlEPXYe9d9ii5pxkyVXeZHf
 YCkOgxs4H7AV2CH5MxNDRnKD+xXGULam0A/eCFJFQBuGU2a1eWLfbxsbkw+f4NLGD9m9+YpijL
 Bg1N15WJK/PQNqIdFG+h3pd1y8iH0rT3QAAAA==
X-Change-ID: 20260328-dpll-mon-j-d88eb48c1f09
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, Vitaly Grinberg <vgrinber@redhat.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272863-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vgrinber@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C941C35127C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Previously, monitor mode wrapped all events in a single JSON array
inside a top-level object, which made piping the output to external
tools (such as `jq`) impossible.
Send a separate JSON object for each event in monitor mode,
making the output suitable for line-by-line consumers. Skip the
global JSON wrapper for monitor mode.

Signed-off-by: Vitaly Grinberg <vgrinber@redhat.com>
---
v2:
  - Fixed indentation
---
 dpll/dpll.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index 9893ca8c..49576d23 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -571,8 +571,15 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
-	new_json_obj_plain(json);
-	open_json_object(NULL);
+	/* Monitor emits one JSON object per event for streaming;
+	 * other commands use a single JSON wrapper object.
+	 */
+	bool is_monitor = argc > 0 && strcmp(argv[0], "monitor") == 0;
+
+	if (!is_monitor) {
+		new_json_obj_plain(json);
+		open_json_object(NULL);
+	}
 
 	/* Skip netlink init for help commands */
 	bool need_nl = true;
@@ -602,8 +609,10 @@ dpll_fini:
 	if (need_nl)
 		dpll_fini(dpll);
 json_cleanup:
-	close_json_object();
-	delete_json_obj_plain();
+	if (!is_monitor) {
+		close_json_object();
+		delete_json_obj_plain();
+	}
 dpll_free:
 	dpll_free(dpll);
 	return ret;
@@ -2173,6 +2182,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
 
 		mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);
 
+		new_json_obj_plain(json);
 		open_json_object(NULL);
 		print_string(PRINT_JSON, "name", NULL, json_name);
 		open_json_object("msg");
@@ -2182,6 +2192,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
 
 		close_json_object();
 		close_json_object();
+		delete_json_obj_plain();
 		break;
 	}
 	case DPLL_CMD_PIN_CREATE_NTF:
@@ -2200,6 +2211,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
 			json_name = "pin-delete-ntf";
 		}
 
+		new_json_obj_plain(json);
 		open_json_object(NULL);
 		print_string(PRINT_JSON, "name", NULL, json_name);
 		open_json_object("msg");
@@ -2209,6 +2221,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
 
 		close_json_object();
 		close_json_object();
+		delete_json_obj_plain();
 		break;
 	}
 	default:
@@ -2273,8 +2286,6 @@ static int cmd_monitor(struct dpll *dpll)
 		goto err_signalfd;
 	}
 
-	open_json_array(PRINT_JSON, "monitor");
-
 	pfds[0].fd = signal_fd;
 	pfds[0].events = POLLIN;
 	pfds[1].fd = netlink_fd;
@@ -2307,8 +2318,6 @@ static int cmd_monitor(struct dpll *dpll)
 		}
 	}
 
-	close_json_array(PRINT_JSON, NULL);
-
 err_signalfd:
 	if (signal_fd >= 0)
 		close(signal_fd);

---
base-commit: 36252727bfc653905bb39bec115a32869452beb1
change-id: 20260328-dpll-mon-j-d88eb48c1f09

Best regards,
--  
Vitaly Grinberg <vgrinber@redhat.com>


