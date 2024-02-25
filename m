Return-Path: <netdev+bounces-74781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE514862C62
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 18:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F091C20C25
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B212419BA5;
	Sun, 25 Feb 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJcdgpmc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560F1862E
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883191; cv=none; b=Fj1xY0bkgwqtvp1W0EtA2Dzv5lqyAbRkMUITJE/wpIY5RlSiLu4NvIIQdU7rwvNRhQ1EJ57C0NkJpNpCFSdXqIOS0ocNGgOreA0CXy3NM9McBZjkdWztKMA3oNI9r4qGhwJ3ZYRLUT7SuuVJenpKabh9pjh7zUFtNd5o5HU0f+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883191; c=relaxed/simple;
	bh=1I0k7Ufr76IpmebVdS3DYr3+/kf91A0cM10ua8RidlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsmALj83kTO2XHnMGeRSbi0HhbncAX/vu/uiYZLTA9k9zE4jmicXoyj44kNKj04gHxX6j6TqUrP0fQ7DB5D41sp/oRsztQ9cSxvOlj/R2KJa/uxYdEDo2E+dFNHJ6/yJBTXcV6kptQc4H9UPThnow9pP6gcCtt4bB/znr5U7Q4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJcdgpmc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d509ab80eso975879f8f.3
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708883188; x=1709487988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcuhTD3Hkz219GABcN0nRRjLsqJ5zc2knXCLNNndOqo=;
        b=mJcdgpmcajFgHw02yXilC/Po5rc6xrdS37Q5R3nv8ui0gN5pYGkOo2tkPKgtRVfW30
         uh+VbwQyF7h+tJlzf1cwcbIHqKDUyt5okDjaFL+xer0eJJ9idH/u2SA4hmlHGVeY6Ned
         YDD87y90aniE86NVFWWTCfBQqXOs6TeJo1rLHn+WAUAG7dQA5Asd5Lme8vvDwtPjiPcw
         FIjRgTEBK1eDy9S0AMe0QRS87B0obR8S4Okl+3803XZmcU8hwnmFFelwDmk/To0bT9Dg
         fGpEKOJZPGLt/sDRcJ4fgohFGE9qxvCnW50a33jX2m1ZxvP2c0CKMcRFYXrntBdXb/FA
         LWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708883188; x=1709487988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcuhTD3Hkz219GABcN0nRRjLsqJ5zc2knXCLNNndOqo=;
        b=tX9MdsoKDdgz04bB/0K+VI6FW1Ovoqh54FTvrXDqNrkeOo9vGG3nOC/aPwhW2Q4myw
         yUaiTvdcJy0WHm9KXJFJopdB1jt3fQXnO9x9IqAw5irb3lf2XGd44/n7AC+az5Px1uqu
         AXAx/X27+fFYVp1jFbrBJyrCerEWydt05QoTg9hr8nGWpIEDMoaBnmlmAz9CSkDsYxbb
         cjxwQL7vt5X/N4VqAGbqdjfk0Mz0Dp6vJiPuzWWm58Htz1nP4LevYL2hIvvstdlva21U
         giZoiIyJ/Cc6j+4lhsCiZTslMogphXitU2tzic510xSlEXzl9oEJGfEpntZOUrejuqS6
         OJdg==
X-Gm-Message-State: AOJu0YyDckJK+Ti6YZmUxtKDnLzbTESSk/SCiBDbUNTIYbHUyNLp9sd8
	VvI3jraR2zzfN2fI5XtBr3EWL+keZN3tabZ1ZeZR7DXHSekxrH65b5dTPmAvxEc=
X-Google-Smtp-Source: AGHT+IHavLOexOBaMqApIC4P8pZVIiV+8JXQuyR/eAQ6OqYP61LviW+ifhGYGqVIfShyrxNHMgW65Q==
X-Received: by 2002:a5d:4fcb:0:b0:33d:d5a6:fbb4 with SMTP id h11-20020a5d4fcb000000b0033dd5a6fbb4mr731651wrw.40.1708883187890;
        Sun, 25 Feb 2024 09:46:27 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:907c:51fb:7b4f:c84f])
        by smtp.gmail.com with ESMTPSA id r2-20020adff702000000b0033b60bad2fcsm5558729wrp.113.2024.02.25.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:46:27 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC net-next 1/4] doc/netlink: Add batch op definitions to netlink-raw schema
Date: Sun, 25 Feb 2024 17:46:16 +0000
Message-ID: <20240225174619.18990-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240225174619.18990-1-donald.hunter@gmail.com>
References: <20240225174619.18990-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nftables netlink families use batch operations for create update and
delete operations. Extend the netlink-raw schema so that operations can
be marked as batch ops. Add definitions of the begin-batch and end-batch
messages.

The begin/end messages themselves are defined as ordinary ops, but there
are new attributes that describe the op name and parameters for the
begin/end messages.

The section of yaml spec that defines the begin/end ops looks like this;
the newtable op is marked 'is-batch: true' so the message needs to be
wrapped with 'batch-begin(res-id: 10)' and batch-end(res-id: 10) messages:

operations:
  enum-model: directional
  begin-batch:
    operation: batch-begin
    parameters:
      res-id: 10
  end-batch:
    operation: batch-end
    parameters:
      res-id: 10
  list:
    -
      name: batch-begin
      doc: Start a batch of operations
      attribute-set: batch-attrs
      fixed-header: nfgenmsg
      do:
        request:
          value: 0x10
          attributes:
            - genid
        reply:
          value: 0x10
          attributes:
            - genid
    -
      name: batch-end
      doc: Finish a batch of operations
      attribute-set: batch-attrs
      fixed-header: nfgenmsg
      do:
        request:
          value: 0x11
          attributes:
            - genid
    -
      name: newtable
      doc: Create a new table.
      attribute-set: table-attrs
      fixed-header: nfgenmsg
      do:
        request:
          value: 0xa00
          is-batch: True
          attributes:
            - name

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ac4e05415f2f..eb35fee44898 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -446,6 +446,11 @@ properties:
                         i.e. requests and responses have different message enums.
                       $ref: '#/$defs/uint'
                     # End genetlink-legacy
+                    # Start netlink-raw
+                    is-batch:
+                      description: Must be part of a message batch
+                      type: boolean
+                    # End netlink-raw
                 reply: *subop-attr-list
                 pre:
                   description: Hook for a function to run before the main callback (pre_doit or start).
@@ -469,6 +474,22 @@ properties:
             mcgrp:
               description: Name of the multicast group generating given notification.
               type: string
+      # Start netlink-raw
+      begin-batch: &batch-params
+        description: Definition of a message call for a batch message
+        type: object
+        additionalProperties: False
+        properties:
+          operation:
+            description: Name of the operation
+            type: string
+          parameters:
+            description: Parameters for the operation
+            type: object
+            items:
+              type: object
+      end-batch: *batch-params
+      # End netlink-raw
   mcast-groups:
     description: List of multicast groups.
     type: object
-- 
2.42.0


