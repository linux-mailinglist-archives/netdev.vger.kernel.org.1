Return-Path: <netdev+bounces-283928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM89HSLB+Gnh0AIAu9opvQ
	(envelope-from <netdev+bounces-283928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:54:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C34C0F88
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C24823006D5B
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0BB3E1218;
	Mon,  4 May 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HV8RQlnw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF63E1208
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910039; cv=none; b=DGTt1F0nkd6T3M2Yvm19eR9j8+r9GvgHcMxX3Gp5JbaDaIS525S9z3yJzMc6yYaGm0p4Kh6kuCBb5VMkjvd4mv5BSyQaul5tIrv3dinsNL5288fWirWErYlh6qPskOV3M4SqeXy3W1LZhYxH/f+ghSLYXubgUqC4HjLcrKfBzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910039; c=relaxed/simple;
	bh=7DoUuX0+RGh2JVfU5wVKKGYKwB5AQXrt1NRBgjRFfGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHoSeIN0XtuRrg+eMxlGNWjEd2V4zKKCYPrzKIoL8z0mVqPG/Qk7ngBFPAQz58Gn/yVU9fByzcyjr/VdLkEb5s9hZC7Zq4jC99/zMTjBTcaeopBGChrf0j0sK6hl9ijwJXdniv8o2imq8AF0Iv9AWwsLhVAcPgk8aBbR/e9q3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HV8RQlnw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777910035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DaQO+lQ/WhzSgRpUYtckS0TDp3/BHCsX9FCd+/WxZyE=;
	b=HV8RQlnwSpmbYnsBdKyvaF4DNDTnJgxf4gGbwn23hrQzG8Yc/wrwztCcCEvOkIWMVg5KPn
	TbVkI5OqbWNcDPKV1FgIvNuswYv4jmvj+aOWe/bUm6hTN5Q1hQXyzLgcYgpvi8+kRb9mak
	Q/lANAuV/W+FBpMJyt13EuHXVR08h6k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-zg4FzEtmO5-QrekueoNmbg-1; Mon,
 04 May 2026 11:53:51 -0400
X-MC-Unique: zg4FzEtmO5-QrekueoNmbg-1
X-Mimecast-MFC-AGG-ID: zg4FzEtmO5-QrekueoNmbg_1777910028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31864195608E;
	Mon,  4 May 2026 15:53:48 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3A4819560A6;
	Mon,  4 May 2026 15:53:41 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 0/2] dpll: rework fractional frequency offset reporting
Date: Mon,  4 May 2026 17:53:38 +0200
Message-ID: <20260504155340.411063-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 124C34C0F88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283928-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Rework how the fractional frequency offset (FFO) is reported in
the DPLL subsystem.

Both fractional-frequency-offset (PPM) and
fractional-frequency-offset-ppt (PPT) attributes are now present at
the top level of a pin and inside each pin-parent-device nest. They
carry the same measurement at different precisions.

The ffo_get callback distinguishes the two contexts: dpll=NULL for
the top-level call (RX vs TX symbol rate offset) and a valid dpll
pointer for the nested per-parent call (pin vs DPLL offset). This
allows drivers to report a different value per parent DPLL if needed.

Patch 1 adds both attributes to the pin-parent-device subset, updates
the DPLL netlink handling to emit both at each level, updates the YAML
spec and driver-api documentation, and adds NULL guards to mlx5 and
zl3073x drivers.

Patch 2 implements the nested FFO for zl3073x using the
dpll_df_offset_x register with ref_ofst=1, providing 2^-48
resolution. The old per-reference frequency measurement is removed
as it was redundant with measured-frequency.

Changes v2 -> v3:
- Keep both FFO attributes (PPM and PPT) at both levels instead of
  moving PPT under pin-parent-device only (Jiri Pirko)
- Unify attribute documentation to describe semantics at each level

Changes v1 -> v2:
- Minor commit message fixes

Ivan Vecera (2):
  dpll: add fractional frequency offset to pin-parent-device
  dpll: zl3073x: report FFO as DPLL vs input reference offset

 Documentation/driver-api/dpll.rst             | 15 +++++++
 Documentation/netlink/specs/dpll.yaml         | 28 +++++++-----
 drivers/dpll/dpll_netlink.c                   | 23 +++++-----
 drivers/dpll/dpll_nl.c                        |  2 +
 drivers/dpll/zl3073x/chan.c                   | 31 ++++++++++++-
 drivers/dpll/zl3073x/chan.h                   | 14 ++++++
 drivers/dpll/zl3073x/core.c                   | 45 -------------------
 drivers/dpll/zl3073x/dpll.c                   | 34 +++++++-------
 drivers/dpll/zl3073x/ref.h                    | 14 ------
 drivers/dpll/zl3073x/regs.h                   | 15 +++++++
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  4 ++
 11 files changed, 125 insertions(+), 100 deletions(-)

-- 
2.53.0


