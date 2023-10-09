Return-Path: <netdev+bounces-38932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC47BD1D1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 03:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F7728144D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 01:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0315BC;
	Mon,  9 Oct 2023 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbgEB4XN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF2A5B;
	Mon,  9 Oct 2023 01:41:30 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58468F;
	Sun,  8 Oct 2023 18:41:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690f2719ab2so952193b3a.0;
        Sun, 08 Oct 2023 18:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696815688; x=1697420488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtSRnSgMWL17EB42FjMa2QRDw0eFDweojqXGzLpNtwE=;
        b=dbgEB4XNtOxWFVQ/LnxZUl8qhXzfp2AViUREoPb1hWSy3zQIJCyAuQJ7UNhshQkU5F
         seTgSAORhwl5mKbDL++hSEmr10pqxg1udQxoiM1QIdCTlx+oysa6KQ34HvfiCyN7VLo6
         6Fw2cyQpH+O8L4STX8K3QdKjMlcUhsbFIgpkRI9vcrghupxjHtO3rzvHmJAdyn+ksFKr
         lresJm6FekdYsEF3UkH+w+rx0phwH1r5BfkeuraS2QhTtIexcGGU89pLco3tNtqKty02
         p989Uj4GyEshhMUr+qVGe7WiCpj0XWsI4Bg1THHR6z83+75Eei3q18fumjmE0QxKGXP9
         F9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696815688; x=1697420488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtSRnSgMWL17EB42FjMa2QRDw0eFDweojqXGzLpNtwE=;
        b=rEX6LLApih0+qovO+Sf9VyN/x2Y869f41Nm762f0U38LWCyThswngtPDqUV0QIRKLg
         hmV/fupxv7j/ShUsvIY5PDpD+YgLQ4UPgBfdSOeEcR2xFrcU3LFp2RDhhgTkOUUGLR83
         F8aT0jZx80tzEG2UcqreqQ7CR7FIsuiBZGdn5zl5cEbcqK8r9xAvcItQWDSEUCUNhqcD
         zteqJZk7wlrU2DflinBJc2SUBmjeqylQmENAMU4w5KsgHycAp2dAjwcK9iOsKGql2YJM
         KO9WHhRopU9gkYFoAmmO24YoAqvE4lcbsM7dG06jrnOUuR6b6GREwdWMuxDSjroR1zYc
         08Nw==
X-Gm-Message-State: AOJu0Yy+qf05HtOcTr9RJytifDU+fMaWN2AS3yTYTkRwSf7Es4WgbuHi
	Rav5m35Wb7jwEWB9SrFb3yqafBzTQJF1I1hr
X-Google-Smtp-Source: AGHT+IER79uJ9eBqtPkQQvqU4IGUSKAZJgxVDce2JOv7F/gGLANgLTSNWoEstnAadYet9eUEVGbFbA==
X-Received: by 2002:a05:6a00:2e87:b0:690:c79c:1912 with SMTP id fd7-20020a056a002e8700b00690c79c1912mr16066977pfb.0.1696815687739;
        Sun, 08 Oct 2023 18:41:27 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id s22-20020a62e716000000b0068fb8e18971sm5132917pfh.130.2023.10.08.18.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 18:41:27 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com,
	tmgross@umich.edu
Subject: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
Date: Mon,  9 Oct 2023 10:39:09 +0900
Message-Id: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset adds Rust abstractions for phylib. It doesn't fully
cover the C APIs yet but I think that it's already useful. I implement
two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
they work well with real hardware.

The first patch introduces Rust bindings for phylib.

The second patch updates the ETHERNET PHY LIBRARY entry in MAINTAINERS
file; adds the binding file and me as a maintainer of the Rust
bindings (as Andrew Lunn suggested).

The last patch introduces the Rust version of Asix PHY drivers,
drivers/net/phy/ax88796b.c. The features are equivalent to the C
version. You can choose C (by default) or Rust version on kernel
configuration.

v3:
  - changes the base tree to net-next from rust-next
  - makes this feature optional; only enabled with CONFIG_RUST_PHYLIB_BINDINGS=y
  - cosmetic code and comment improvement
  - adds copyright
v2: https://lore.kernel.org/netdev/20231006094911.3305152-2-fujita.tomonori@gmail.com/T/
  - build failure fix
  - function renaming
v1: https://lore.kernel.org/netdev/20231002085302.2274260-3-fujita.tomonori@gmail.com/T/


FUJITA Tomonori (3):
  rust: core abstractions for network PHY drivers
  MAINTAINERS: add Rust PHY abstractions to the ETHERNET PHY LIBRARY
  net: phy: add Rust Asix PHY driver

 MAINTAINERS                      |   2 +
 drivers/net/phy/Kconfig          |   7 +
 drivers/net/phy/Makefile         |   6 +-
 drivers/net/phy/ax88796b_rust.rs | 129 ++++++
 init/Kconfig                     |   8 +
 rust/Makefile                    |   1 +
 rust/bindings/bindings_helper.h  |   3 +
 rust/kernel/lib.rs               |   3 +
 rust/kernel/net.rs               |   6 +
 rust/kernel/net/phy.rs           | 733 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   2 +
 11 files changed, 899 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: 19537e125cc7cf2da43a606f5bcebbe0c9aea4cc
-- 
2.34.1


