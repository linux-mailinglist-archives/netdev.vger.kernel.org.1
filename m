Return-Path: <netdev+bounces-27274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4F877B554
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A871C20430
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C484A955;
	Mon, 14 Aug 2023 09:24:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D2A954;
	Mon, 14 Aug 2023 09:24:27 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48960D7;
	Mon, 14 Aug 2023 02:24:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe9f226cdbso2387471e87.0;
        Mon, 14 Aug 2023 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692005063; x=1692609863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEq4tMvABy02Aj9KhKkOBmN5DwD6++P6cc/KYaesST8=;
        b=kwJW+qTe7U7dR7ZSg1LyK1C3o89JFyEyaFt1UAYxszT7fWnRwYnXIomXUCuxDp55XB
         BU/B0DmyB3KlHrvIh5Yf3ltNlW5TUBqYFJhH6SYgRbIucYFZIbpGs7DL8U6NFrap05oI
         knmO+wvsQKcPXvq1HaIZm6+xzAOD4lRy5tz4xRhHFgxKdZqPCHn62GNWjht/XE0f83oj
         rElHr5iLIJdYTAoAVXWUhSt5h0Euwh6UOfSClUA2iCCnfYtFMYSM9Uxx1HUdq3dEIo9w
         XewgyAcJXgCs2brD+cKd7HoIJomWNAn7K4b9pisaHWyy8u8Kp/CFyFNYkyjT8rUiijN5
         EvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005063; x=1692609863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEq4tMvABy02Aj9KhKkOBmN5DwD6++P6cc/KYaesST8=;
        b=WEUkl1IIgzSDFvIvb2U3Dgzi+1qXj+jOh5PDAuyyaylXU89N4o8uG7/gpMJV/P1/CY
         yMwX0g/AYYpZeJUXCdkUaAa5S1+CbSil4pvUPQYVtLzKd5iRxiP4eswjy5JfSSQvidIo
         SAqtP4oATnKBvf6ZKcdBpGz1TcwGNGYQs/fzZNn/16lObFdXbJ+z86hzyYtokv9UOs0A
         Fz2dzFe4eTdhG3117ytz30VzbOZV848mfTpimskc1bUhUAPaXhY6iQETUIb8i9/Ieq0m
         sDK3DHFU92LcjuXIBOgu14c0jf3HgOdbWdf1En7hYyhHaDXb03kpcIyJc/YAX9sT+1Sd
         n6Mg==
X-Gm-Message-State: AOJu0YyNbtMlwcQiymKew+GUdYA+aQIJ9fpFgBa89AGZKF+NiiHXRRGU
	TG8kyLNmEyuCXZOqs6WxYYw=
X-Google-Smtp-Source: AGHT+IGto0XKxg0a783A24zi+6GrrpKv8JVYmqks8BIDAX2izp8hCHaRxaHrtMeiurgnw2hG7qYyXg==
X-Received: by 2002:ac2:5bc8:0:b0:4fb:9d61:db44 with SMTP id u8-20020ac25bc8000000b004fb9d61db44mr4791668lfn.12.1692005063397;
        Mon, 14 Aug 2023 02:24:23 -0700 (PDT)
Received: from micheledallerive.home ([2a02:1210:6051:ec00:61e9:3767:83a6:9bd9])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7c6c5000000b005224d960e66sm5314879eds.96.2023.08.14.02.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:24:23 -0700 (PDT)
From: Michele Dalle Rive <dallerivemichele@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Davide Rovelli <davide.rovelli@usi.ch>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Michele Dalle Rive <dallerivemichele@gmail.com>
Subject: [RFC PATCH 0/7] Rust Socket abstractions
Date: Mon, 14 Aug 2023 11:22:55 +0200
Message-ID: <20230814092302.1903203-1-dallerivemichele@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series is intended to create Rust abstractions for Sockets
and other fundamental network entities. 

Specifically, it was added:
- Ip address and Socket address wrappers (for `in_addr`, `in6_addr`,
  `sockaddr_in`, `sockaddr_in6`, `sockaddr_storage`).
- Socket wrapper.
- Socket flags and options enums.
- TCP and UDP specific abstractions over the Rust Socket structure.

This series is a RFC because I would appreciate some feedback about:
- The structure of the module: is the division of the files and modules
  appropriate or should it be more or less fine-grained?
  Also, should the `net` module export all the structures of its
  submodules? I noticed that it is done in the standard library.
- Whether the documentation is comprehensive enough.
- A few other specific questions, written in the individual patches.

I would greatly appreciate any kind of feedback or opinion. 
I am pretty new to the patch/mailing list world, so please point out any
mistake I might make.

The changes in this patch series are based on top of the latest commit
of `rust-next` in the Rust git tree: 
19cd7b5d229c ("btf, scripts: rust: drop is_rust_module.sh")

Michele Dalle Rive (7):
  rust: net: add net module files and shared enums.
  rust: net: add ip and socket address bindings.
  rust: net: add socket-related flags and flagset.
  rust: net: add socket wrapper.
  rust: net: implement socket options API.
  rust: net: add socket TCP wrappers.
  rust: net: add socket UDP wrappers.

 rust/bindings/bindings_helper.h |    3 +
 rust/kernel/lib.rs              |    2 +
 rust/kernel/net.rs              |  185 +++++
 rust/kernel/net/addr.rs         | 1215 ++++++++++++++++++++++++++++++
 rust/kernel/net/ip.rs           |   73 ++
 rust/kernel/net/socket.rs       |  641 ++++++++++++++++
 rust/kernel/net/socket/flags.rs |  467 ++++++++++++
 rust/kernel/net/socket/opts.rs  | 1222 +++++++++++++++++++++++++++++++
 rust/kernel/net/tcp.rs          |  252 +++++++
 rust/kernel/net/udp.rs          |  182 +++++
 10 files changed, 4242 insertions(+)
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/addr.rs
 create mode 100644 rust/kernel/net/ip.rs
 create mode 100644 rust/kernel/net/socket.rs
 create mode 100644 rust/kernel/net/socket/flags.rs
 create mode 100644 rust/kernel/net/socket/opts.rs
 create mode 100644 rust/kernel/net/tcp.rs
 create mode 100644 rust/kernel/net/udp.rs

-- 
2.41.0


