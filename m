Return-Path: <netdev+bounces-257655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BxoBAZZhmnDMAQAu9opvQ
	(envelope-from <netdev+bounces-257655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 22:11:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F3103570
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 22:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7362430143CD
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DA311979;
	Fri,  6 Feb 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgdEEqD8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC4130FF36
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412291; cv=none; b=GxKkoZWXiwIpcLvnMHuvxFyyn1Xnf3qmM9rzGX1ZNKnYpxhKPF7QuCh79jeDTUW/FFzWKw+iTqalziqMRIkxV45afDEksT7Kjd10+HhfPEp2oPlgoVuhnm2Uu0hcssMEdcn46g0Snbf4CtqwLzVjA4ja7CzX9wrSR+qL535QyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412291; c=relaxed/simple;
	bh=kL57fBKlmHkBnVvgR2BfOxmtS3fp+/REtPShzx+pJuE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SGFRcG92n5LYQo+SkPCXMjgvp4A7gmOic6luM1KZWAkzn8cbd9ZR8Bx4d/8FgLHgU76Nj0Zw+WH2qBKWB9Vk4x2HLvjCwaZQG6L9le/fa7uDqZ0e+xM8vNGPMmFzMoLV5jeKArRprZKX6Gu/zNQugG2HXJXKHaF03E1buDKCB+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgdEEqD8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-793fdbb8d3aso26621627b3.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 13:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770412290; x=1771017090; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mV+HKKahC8KYSqSok+U2NwS6/9F+LqR4+YkFy7aL5wc=;
        b=MgdEEqD85LJC74Gu1aK7+9KpKW7REKaGWpFXLUZOO12uovggbmnnPVbVzjw8iibvqE
         AW7KU3vAVrVLyA2RZqv9OUU4ilcGB6FIMpqcAmSEU592TsJkoj0J36ehS1iVGfrsoYiI
         XzS1eVzoD6hAuS1Y2afF2bFgloUSwFJzcrORLFMlHBQPSnwUKSh8DNbiG1H/780gET2U
         OjbCFsLTOf1Ga0LEeQ8xvEQDilDNEYMeQxjSH8PQ3lFlBMdFW2aEyLycYjcyYSZevna4
         qkbDMuJ+dDtF3CEIJglgFEHXIsVSAPNul9Ks/yyE4JEnhxstLDtwJqMn78TnWxJEw01q
         XoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770412290; x=1771017090;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV+HKKahC8KYSqSok+U2NwS6/9F+LqR4+YkFy7aL5wc=;
        b=i5PqRWfi2w0frIzcBxeH1UkHXexpkYPphOn7aaijo9N0IB6+nnmKolGSPdwDtOvbaW
         bC7Im8ZUNINlVE7ODJ8SEUqANqUHp6+gTF5wI15RHWPxYYXKTvcoUhfajoPBVDHZVLdA
         gI8CHb5XLVpocUGxKFCrDjpEW4XFykaw8M69Gbd0QDpyI3F3PnMBgyS1/kUPbYvE6FsI
         CiXzVM9EQwrGnCCrAQ/qGXgdX7wKkKgRGN+BJIWyOjjpfbu0sOXmyph7hJbKQaNQdIQi
         PQZMJjF/fycqYjC1Gu/1Vx6JdCgh606vNjN/ZqnGUpsgYfHB8JV66KEzF8a5dGIviSal
         iIZQ==
X-Gm-Message-State: AOJu0YwEFThosuDlpIAAz6sNd41QwL/0j/HcDqRPB9DgU5huXPFJbF3L
	o6OrNLbuR28I2sy6hRPnMTIGrVIlliTGx4RR1bSIzf1VgqMYE8ICIhST
X-Gm-Gg: AZuq6aIzYJIRlrwoPrgxPFpv2FOAbSb/WNh3yXb8RTpSlpHB2WcAsY9LsaXmF+ks8E6
	ixugnpTh8uTj5h68w0uiVn6+R5TnPVuEH/zDXn6R8oMKw8ixQaAkRrqxijMG1dKK+N/8Q5F8nWY
	o72so+fKO/Usz2amQ3WRWskYUoxjZjli+iO7s1To77xkCWBQug5bmtsWEFhwyQl480E35/AGVBi
	PYbtgerEXKlLdJOgpE4oaUe4gWFyKv+xNLicX11ctlsOjG/GIi48Lu0am+E6PXTvLkkUOc8A5kK
	wHGK/z709Bp3EwnXtvfF2fhJECt6ER6OUhKRF55dJHmjPS10lT8LNJkvMenB2PSUDseHvd/ry9e
	biyZ/ZsdwhQvVHCzqyO1G7Wi1qZvXrt9kyvuFICR2Ay/hjGq0v6dAEMstXCBP2taSPenkYnTvyd
	nwWPnV1SRH
X-Received: by 2002:a05:690c:6885:b0:794:c679:1d1d with SMTP id 00721157ae682-7952aaa002dmr43174857b3.24.1770412290348;
        Fri, 06 Feb 2026 13:11:30 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a1d82fesm31732477b3.37.2026.02.06.13.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 13:11:29 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH iproute2-next v2 0/2] devlink: support default flag attr
 for param-get and param-set commands
Date: Fri, 06 Feb 2026 13:11:28 -0800
Message-Id: <20260206-param-defaults-v2-0-1ce78e2c5a31@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAABZhmkC/12NQQ6DIBREr2L+ujRAqoSueo/GBcpHf6JiAImN8
 e4lpqsuX2bmzQERA2GEZ3VAwEyR/FJA3iroR7MMyMgWBsllLYSQbDXBzMyiM9uUIrNKN87Zrla
 ygzJaAzraL+EbaA1+SyjZgnuCtsQjxeTD57rL4ir9zOrfnAXjrNe64Q+hasv1a5gNTffez9Ce5
 /kF2oeErbsAAAA=
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257655-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[resnulli.us,davemloft.net,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 830F3103570
X-Rspamd-Action: no action

Add cli support for default param values introduced in the
accompanying kernel series [1]. Here is some sample usage:

[1]: https://lore.kernel.org/netdev/20251119025038.651131-1-daniel.zahka@gmail.com/

 # dump params with defaults
./devlink dev param show pci/0000:01:00.0
pci/0000:01:00.0:
  name max_macs type generic
    values:
      cmode driverinit value 128 default 128
...
  name swp_l4_csum_mode type driver-specific
    values:
      cmode permanent value default default default

  # set to l4_only
./devlink dev param set pci/0000:01:00.0 name swp_l4_csum_mode value l4_only cmode permanent
./devlink dev param show pci/0000:01:00.0 name swp_l4_csum_mode
pci/0000:01:00.0:
  name swp_l4_csum_mode type driver-specific
    values:
      cmode permanent value l4_only default default

  # reset to default
./devlink dev param set pci/0000:01:00.0 name swp_l4_csum_mode default cmode permanent
./devlink dev param show pci/0000:01:00.0 name swp_l4_csum_mode
pci/0000:01:00.0:
  name swp_l4_csum_mode type driver-specific
    values:
      cmode permanent value default default default

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Changes in v2:
- don't create format strings with snprintf()
- delete dead code for default handling of port params
- split uapi change into separate commit (this was already committed so not appearing here)
- Link to v1: https://lore.kernel.org/r/20251117-param-defaults-v1-0-c99604175d09@gmail.com

---
Daniel Zahka (2):
      devlink: Pull the value printing logic out of pr_out_param_value()
      devlink: support displaying and resetting to default params

 devlink/devlink.c      | 127 +++++++++++++++++++++++++++++++++++--------------
 man/man8/devlink-dev.8 |  22 ++++++++-
 2 files changed, 111 insertions(+), 38 deletions(-)
---
base-commit: cd01762163b719361ff7aeaa7f433ee94363497f
change-id: 20251112-param-defaults-d796ffdb572b

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


