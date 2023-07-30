Return-Path: <netdev+bounces-22594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8C76845A
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 10:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52141C20A33
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD7E810;
	Sun, 30 Jul 2023 08:05:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42A1361
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 08:05:34 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117401BF4
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 01:05:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-317716a4622so3253157f8f.1
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690704330; x=1691309130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JpH7d50QcjlB0UPKJcTbCmQKM5Qu33XaovPiSJVQEs=;
        b=ZjH2k4XIfgl6uS73UzgK4wovQ15iQxQGiwFX7IOQscCb+shwV37MQ8aItVNiPlSuQ6
         IlnMNRW1qAhizdzjLqAUW6E7f6R4zPGiFbPvkxnuoBHMSjGI5JXPWnR8CjcdU6n2f1EK
         env7uzYZcAl1Gkf/V0xTRWfBZ/MpUKACyHI1DEKI3JVnd/0cMi3KiuGXhNGp9i/Ty/c9
         /uxhBzDOKBmcAvLa7+J+i2+/MtZvlW83uieHmxKMiSBiYd04/iWy4WSjgWFzPtuitsVf
         QgFUlBLgrG8LMpNlT49e1l+0w/rbahlCtd6LxGn5xCJA61sczDrKx3l5VMTg1FJrXsdj
         ++Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690704330; x=1691309130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JpH7d50QcjlB0UPKJcTbCmQKM5Qu33XaovPiSJVQEs=;
        b=RhCrYGksfR5xUFLTtMxKDQ0CHpslmT5+b4oV52oFlPYxjIS8y8CMyN0tVB/wiEaOec
         khCOpCntXXEaSMTVgvtZdR0w1Dk8ezh0Vv7HiDOteh4GM7OCmO+Nk6X0Tkg9A6eS0vXM
         NjK2MHp379MgayPjwdCKjGKORIVADSyOCWIUEeM+KLHQViMZaZafcGoxKfAgEVi97jk8
         Wz53XMaX6R31d4wankwLGDFnj9C2Krs0B7cMXXBXZo+p0GPNu3kZNluYVGklqqdBp0Sj
         Uzj2is3EO+LiIAVEx7Xp7QvVrw7kFSb89YIBHa/3L5nr9g4Kqib1qnhpTHy6RU2ZXD0t
         IuxQ==
X-Gm-Message-State: ABy/qLaEFldIVFKV0l/zJMW2LAQuBImQ8WX3LswJFzIW83s/8do0rC21
	IqVENPVHQCfAkOiTBw11FCnRrA==
X-Google-Smtp-Source: APBJJlGd5gAPj/i7sI/3N9J/Nir1AuCmhJl8wHThq6nlSOmEiXmZovxjHRXi6Otdbw5V65hUCZsQPw==
X-Received: by 2002:a5d:5101:0:b0:317:64ca:eaf1 with SMTP id s1-20020a5d5101000000b0031764caeaf1mr4424857wrt.17.1690704330306;
        Sun, 30 Jul 2023 01:05:30 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm9338684wrq.115.2023.07.30.01.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:05:29 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 0/4] mptcp: cleanup and improvements in the
 selftests
Date: Sun, 30 Jul 2023 10:05:14 +0200
Message-Id: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALoZxmQC/z2NQQrCMBBFr1Jm7UAaQY1XERcl/dEBE0NmlELp3
 Q2CLv7i8eG9lRRNoHQeVmp4i8qzdBh3A8X7VG5gmTuTd37vjv7Er6rWMGUusL7F+H/larGy4pE
 MaspZNLIbg4tpPgSkQN1aG5Is3+KFfg66btsHKLzSt4sAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=R+PsDSeOsK6DRQCgnPaQ0p8AQt2Q2fy33uMXa6qwvZo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkxhnIeqEaf/93z9Oq2kkK8awgQo6LIJLZJuk70
 JbrNVHBe/GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMYZyAAKCRD2t4JPQmmg
 cxNZD/9y/26FJR4a4x5mXCtzWRpRNEs6apsl4qRVW5GrS8INFeu8tmHSmSi1UPe3w4HOqkzNIOF
 sh5+Nh5JQvqUVl6stWCEYt+KhLmN3UnFbHhG18EJ6V82LAzuCBnImFTPsYDEwfBWkvXzYI0pV7W
 M8t11X4K+AJQqnj15rYzy/gFG+T35RetnT/dsrXhBa3OGID1L9A90sWG5v7JUpx+6/5L7h8zliM
 plGTFAOri3/5S5F2rwMrQ4QTKm1ZSwo5O6S0pt5ZeY0FVdoPuvvwNanyH6/H2WpLixxK5Be7sNg
 m7Xery9sz3mLwW21DcXsxmtC6rQuGtJrc9m1keKOIxdefgBve/wb9U5GNYylMlwcXBp4xHRUesD
 8NTciPV7VU/vmVYBRYQ28qLLTQXJK7v45C/wsukEPuWQIGlnQQeGEBFVHMYwP1I+JeQ5+v+tGE0
 AjvLfpYrkRfeygXmt2xMRUQ039qjJNi+Ey4/YnLN4/j+0h/BB4enFxhDxApJ3vvH7osV7Zqjsfn
 tAcObFdSf42A8/VYoEwh0MTdTZx1h3bcDgENlPEB5leE8ujG2OFzQSv3AP0VZs62GmiBigM2LjP
 8r8oScgrtZnFPGm+9cxnU2LZPu/s0HRD6jYZ23pOHScfQLu3h182RkLXOQrm1ujOtuNs0gCo/GC
 o/M4iQ+IGPmbz2g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This small series of 4 patches adds some improvements in MPTCP
selftests:

- Patch 1 reworks the detailed report of mptcp_join.sh selftest to
  better display what went well or wrong per test.

- Patch 2 adds colours (if supported, forced and/or not disabled) in
  mptcp_join.sh selftest output to help spotting issues.

- Patch 3 modifies an MPTCP selftest tool to interact with the
  path-manager via Netlink to always look for errors if any. This makes
  sure odd behaviours can be seen in the logs and errors can be caught
  later if needed.

- Patch 4 removes stdout and stderr redirections to /dev/null when using
  pm_nl_ctl if no errors are expected in order to log odd behaviours.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (4):
      selftests: mptcp: join: rework detailed report
      selftests: mptcp: join: colored results
      selftests: mptcp: pm_nl_ctl: always look for errors
      selftests: mptcp: userspace_pm: unmute unexpected errors

 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 452 ++++++++++------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |  39 ++
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |   6 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  33 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 100 ++---
 5 files changed, 329 insertions(+), 301 deletions(-)
---
base-commit: 64a37272fa5fb2d951ebd1a96fd42b045d64924c
change-id: 20230728-upstream-net-next-20230728-mptcp-selftests-misc-0190cfd69ef9

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>


