Return-Path: <netdev+bounces-52081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3707FD3A7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF3BB213E8
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DBC199BD;
	Wed, 29 Nov 2023 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFt1X9D5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B967E1;
	Wed, 29 Nov 2023 02:12:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3331974c2d2so226515f8f.2;
        Wed, 29 Nov 2023 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252748; x=1701857548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AbJYNCZCEXbvI4J2J2Wp9nxKJb3engyS4lA/qlDLGo=;
        b=YFt1X9D5N/q4miq1WJL8tfvnHnb+n6NcxwOQnqD1blR/ePiChKEzM8+k5ZHS7g++Ia
         2n+E0OB2cUUWxRUjL2Tz3CyPeoKoNr+KDs2q4v8veBsIdOFp2/hmVQHZGC4rwgarsbht
         W3u7ggTz3HpMh7/IH6GipYyOdE5/ltXkvjPl0BmGp2OEvrGdmcHYWvODIWMOKbm5FCu3
         raRQ3VG9Yp6Li1sunhFflOOAJqDWMCcL00d9ye0pgkmDb500VlI9oxXzsIqjzcAHauRz
         Ct4gYWGxvcEmFHfHZt4hBR3Ez/aIqiO2LGPVdEWEOXK4yXlHcPs1tOD8oTVCzzzTyPfL
         JmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252748; x=1701857548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AbJYNCZCEXbvI4J2J2Wp9nxKJb3engyS4lA/qlDLGo=;
        b=ULkDitU0l2um8nELLhiREOm+C4wD/ZoZBTEweQq4OPnbFc3xBwVFjD/6R3rhRP0CLu
         DAfGlu+TRbH1bYkKcQH4KULB4hwVdzOifl/xq7PiU9aDfMY5hxi63U8OKsyEzGZIkLcK
         mVNo6R1CR92Pdpp+dOTLQzEQjlXuqQ/W9qDNrv48FstuyFeixscjGVv0ioS7jTY+gQh1
         UFPc5b4SMLvZG9cbLV0HZ/TU+CkEqp8JLcCG9geB9mH0stQmJv3L2H0zMoSzwOKrhM5N
         yXFMwFmxdA4GBMnuXigjLuAWyPIuRAmNJx+Aw+zwMXF/pW3nWpBDimkOfuYHJv3/SlPQ
         Ymsw==
X-Gm-Message-State: AOJu0YzqKUss/1dZV0ZMSHUVTF4X/1yYrhvfyaqnvQn2PGsE12mxqIDu
	/sVdi1YZL7nperL36aCBp2O9Q21RXg+1bA==
X-Google-Smtp-Source: AGHT+IFPod///Z4kO2+zFmFB6JpGBcttSNViYKLHLZAGJBR0BhpdkxGCQLHmd8IBUT7CJWTH2+xyqQ==
X-Received: by 2002:a5d:4b88:0:b0:332:cb97:2cbf with SMTP id b8-20020a5d4b88000000b00332cb972cbfmr11492828wrt.24.1701252747575;
        Wed, 29 Nov 2023 02:12:27 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:648d:8c5c:f210:5d75])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm17296877wrc.95.2023.11.29.02.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:12:27 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC PATCH net-next v1 0/6] tools/net/ynl: Add dynamic selector for options attrs
Date: Wed, 29 Nov 2023 10:11:53 +0000
Message-ID: <20231129101159.99197-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a dynamic selector mechanism to YNL for kind-specific
options attributes. I am sending this as an RFC solicit feedback on a
couple of issues before I complete the patchset.

I started adding this feature for the rt_link spec which is monomorphic,
i.e. the kind-specific 'data' attribute is always a nest. The selector
looked like this:

  -
    name: data
    type: dynamic
    selector:
      attribute: kind
      list:
        -
          value: bridge
          nested-attributes: linkinfo-bridge-attrs
        -
          value: erspan
          nested-attributes: linkinfo-gre-attrs

Then I started working on tc and found that the 'options' attribute is
poymorphic. It is typically either a C struct or a nest. So I extended the
dynamic selector to include a 'type' field and type-specific sub-fields:

  -
    name: options
    type: dynamic
    selector:
      attribute: kind
      list:
        -
          value: bfifo
          type: binary
          struct: tc-fifo-qopt
        -
          value: cake
          type: nest
          nested-attributes: tc-cake-attrs
        -
          value: cbs
          type: nest
          nested-attributes: tc-cbs-attrs

Then I encountered 'netem' which has a nest with a C struct header. I
realised that maybe my mental model had been wrong and that all cases
could be supported by a nest type with an optional fixed-header followed
by zero or more nlattrs.

  -
    value: netem
    type: nest
    fixed-header: tc-netem-qopt
    nested-attributes: tc-netem-attrs

Perhaps it is attribute-sets in general that should have an optional
fixed-header, which would also work for fixed-headers at the start of
genetlink messages. I originally added fixed-header support to
operations for genetlink, but fixed headers on attribute sets would work
for all these cases.

I now see a few possible ways forward and would like feedback on the
preferred approach:

1. Simplify the current patchset to implement fixed-header & nest
   support in the dynamic selector. This would leave existing
   fixed-header support for messages unchanged. We could drop the 'type'
   field.

   -
     value: netem
     fixed-header: tc-netem-qopt
     nested-attributes: tc-netem-attrs

2. Keep the 'type' field and support for the 'binary' type which is
   useful for specifying nests with unknown attribute spaces. An
   alternative would be to default to 'binary' behaviour if there is no
   selector entry.

3. Refactor the existing fixed-header support to be an optional part of
   all attribute sets instead of just messages (in legacy and raw specs)
   and dynamic attribute nests (in raw specs).

   attribute-sets:
     -
       name: tc-netem-attrs
       fixed-header: tc-netem-qopt
       attributes:
         ...

Thoughts?

Patch 1 adds missing scalars to the netlink-raw schema
Patch 2 and 3 add dynamic nest support to the schema and ynl
Patches 4 and 5 contain specs that use dynamic nests
Patch 6 adds support for nests with a fixed-header

Donald Hunter (6):
  doc/netlink: Add bitfield32, s8, s16 to the netlink-raw schema
  doc/netlink: Add a nest selector to netlink-raw schema
  tools/net/ynl: Add dynamic attribute decoding to ynl
  doc/netlink/specs: add dynamic nest selector for rt_link data
  doc/netlink/specs: Add a spec for tc
  tools/net/ynl: Add optional fixed-header to dynamic nests

 Documentation/netlink/netlink-raw.yaml   |   43 +-
 Documentation/netlink/specs/rt_link.yaml |  278 ++-
 Documentation/netlink/specs/tc.yaml      | 2074 ++++++++++++++++++++++
 tools/net/ynl/lib/nlspec.py              |   27 +
 tools/net/ynl/lib/ynl.py                 |   54 +-
 5 files changed, 2462 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/netlink/specs/tc.yaml

-- 
2.42.0


