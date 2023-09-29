Return-Path: <netdev+bounces-37096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859177B39BD
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A87AA1C209CA
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE666690;
	Fri, 29 Sep 2023 18:11:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D76668B
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:11:53 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1723C1B0
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf6ea270b2so112123125ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011111; x=1696615911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRDHdIW5nw7N6euQ18/oNZUo9zrsO3GFIVaYI09JZgc=;
        b=TT6RHtIWvN95eCOp8T27vH9aEUCM96GdHzjX7zVPjXFzrBxOduTG9sPMU0q6ecfXst
         nQj/AJa2J+39HqqMmoLV4TtA5ZymJ5pYZMFLCIgHj1xQIX2IXa+ELSIB/8IEEqHk0CMj
         ohjTiWZP7xk4mQfuIvVT+Mq4lZaCOT103bjH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011111; x=1696615911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRDHdIW5nw7N6euQ18/oNZUo9zrsO3GFIVaYI09JZgc=;
        b=heYv+9bACWxOdktm50vnPTPAVyTJJ2lojg2uVVSvQuSh5o/sjHF5HTRiyfpG8cdSQZ
         9J72ZF0yfsREEBEj3h9yU3PMne/snOeVjuXFQ/pxgte0qcAM4Q0tt2cpcfEMCs+4A0Ed
         O3VUXib7sd5DrSkM8vdHgZXBLJWrfMANRooJoaNYpkhdaeH3+QKxnxOJCMm36DObpD8H
         o1Ygk2NwTJ6SrIZ76iqwArv4fEm+GDys52XZamwzmFafKbgQl7mZa8DcdoCW1Q44nhK0
         DAmbuyddyVXODvMJOf5A0GbCy5bmLQcTe8lIkKoNNddu71jkXTpND7BQvPU5cs9O9wm3
         zHCw==
X-Gm-Message-State: AOJu0YxuE/RC0d9skXVYPPOzEgWFso/tUUXNzaeniS84pRhO3Dj4/74V
	T+rwnrYqBK+hxX0PHKXoLuMH5A==
X-Google-Smtp-Source: AGHT+IFiJyR1YutI7z9kl3HMwVpOMbQDE1YOxWXmuYGounHs5et49gVV+TVDs64OglQsOZhw3BDjew==
X-Received: by 2002:a17:902:ef96:b0:1c4:6ca6:35b3 with SMTP id iz22-20020a170902ef9600b001c46ca635b3mr4090640plb.44.1696011111522;
        Fri, 29 Sep 2023 11:11:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090282cb00b001c3267ae317sm11820272plz.165.2023.09.29.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:11:50 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Raju Rangoju <rajur@chelsio.com>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/5] chelsio: Annotate structs with __counted_by
Date: Fri, 29 Sep 2023 11:11:44 -0700
Message-Id: <20230929181042.work.990-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=keescook@chromium.org;
 h=from:subject:message-id; bh=3BZuEw+lDTMcDOBdSeo10PeNdfF017VDbBDbHm/Aw7E=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxNkPbApQM0PRdw5XGzeD4wn9M2Q4hhHg+EUI
 +pu8Y62/lCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcTZAAKCRCJcvTf3G3A
 JlIdD/9vS8s1svUJVLgcGlTGpttcmgIm8uPBrJhQo4HWinroPvO700Ft2x5otrpS53fYgd4ez/+
 WPqFs9/JAdy/isZcoif+wp3zPItQJL1mbd6XBZ7AqE08BIIHe0soj5AwkZddsRu1stIvvqutyt8
 U7TP72+WR0Ok3zDICbfQO9uCyP+BjBoHuSH6ucZJzoW3OVKYbV6p/M+TtXWTObKU/DwwJSd/SCk
 JFjTMD+fB8l7T0B4WaHKQfCS/G4k2TTzLUcyGE5hx8e4LbFoOePuhvRanBZaTrGhEO2A0o6mb49
 vky/90bG4LKQt7iH7qNg+2Tykp/lOCMEt+zukwV9h1OnEdizMGBACZ4YJmXs6ZYyzwlrr3lhwhr
 ZvdUFvTWhQieEVmwvmD6rMWGMeYuCIqzLhY/pV37OfULuVwFXrBv0yE+2wViXgZM4C7GVsLln/a
 Jmlfw4K6CR9jYPkBS5pqvlRe1bBIKIKmuajBDShyNb9S3oHaYLRtNfgsRayhrQxlqOBFxWf4UdH
 dEurVIiiI9K4ewqxSbjXG6BSggiyU2A2Nz5lW/DKUw3kqlxfoX12Jw5oa3uz3i6gUL5ww4ty4aF
 +BF/1xZdkmOevxftk80KwlQ3qA5n+Y7kq1jn5q9du5shipXVjNFoABZFtpj5aMAXE2Rh1v3Ry54
 SKDEscG T2ujIL2A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This annotates several chelsio structures with the coming __counted_by
attribute for bounds checking of flexible arrays at run-time. For more details,
see commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").

Thanks!

-Kees

Kees Cook (5):
  chelsio/l2t: Annotate struct l2t_data with __counted_by
  cxgb4: Annotate struct clip_tbl with __counted_by
  cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
  cxgb4: Annotate struct sched_table with __counted_by
  cxgb4: Annotate struct smt_data with __counted_by

 drivers/net/ethernet/chelsio/cxgb3/l2t.h                | 2 +-
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h           | 2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
 drivers/net/ethernet/chelsio/cxgb4/l2t.c                | 2 +-
 drivers/net/ethernet/chelsio/cxgb4/sched.h              | 2 +-
 drivers/net/ethernet/chelsio/cxgb4/smt.h                | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1


