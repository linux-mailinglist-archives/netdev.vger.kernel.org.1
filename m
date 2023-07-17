Return-Path: <netdev+bounces-18178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED2B755A96
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 06:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C873D1C20A41
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 04:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CFB524B;
	Mon, 17 Jul 2023 04:12:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BE5236
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 04:12:17 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF1E43
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 21:11:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e97fcc60so2509376b3a.3
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 21:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689567119; x=1692159119;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hHdzxwtEliVXSVZnVF24kTqq+snac10wbxH1dPQWAY=;
        b=EO/ql6X5tMl9hTDVTOLkUyp8ziyYaLlCH0jdiPCHmB6yMhnKzVAEna09QEATyOABFB
         Z3aq3aNDczKTVfboEzBFTgrPc42dRnqNFJY+KBini+/t37p/Aet5mw7aIrFG9/m9211f
         SWhe8EwxDupwcDBazCgNpUaRG4hSuUgmAlty+fMaTEWmmuZRiCeOKMWyIzCOB69OMJzi
         +Uh8cA7yc1aTHV4JocZ+3jTDdZmF2nz4v/hxnF6brbnbPTg4HXOVIeUuOzQJEstCTtnz
         O7ChLV7tpEwESqCp+OAdB+EZ9HAjlvelbo+Jw2xnCF80eNLvXpbgGquOn4CcgITx3qn0
         21/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689567119; x=1692159119;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hHdzxwtEliVXSVZnVF24kTqq+snac10wbxH1dPQWAY=;
        b=Rvta5mDXrcLDctE9Tt9R1kCByprHao5+vhlsLPYLFmw9NJn8p1M4oA5PCJb5udNa66
         d8Qgbrp9CfwNJieLtgvYEplyqGw2uSojzfPYaBKM3yiMgoPipcdda55+frwAs6rZ4JvG
         CHv37Ipl1XpbEfWVdBjcnlJmICs0b9PuiywYI7PClmQL0brCy+B78QlrIKD1nnQjrxdg
         +H0VM4nDI8Iq9uM1TDVTp+6ZX3Sz5AFDSAC2xYI6nZ7datAJx6g4RrKig8Nx+chATioJ
         1Ci34SzZnK29MXXE7dHmwA32LUsAjV30FA1glCh8FDcvE9AvgDuaAoQKFL2mwpPXpPMP
         dcfQ==
X-Gm-Message-State: ABy/qLYCDNT4ZvHuPL/eEUCvJD8kGPhMNsoFIWfFguOxTTrOhbTsqFaA
	ZyqOG906uaCrafK13+yR/r9lAbejwbt6pA==
X-Google-Smtp-Source: APBJJlFEFQG6/V3T0EFrcnJsZwviAfdiCZYTPCf/OBejhnIC7WpA/ArLSD7srUsI3bWzBqlQB39yMQ==
X-Received: by 2002:aa7:8891:0:b0:62d:8376:3712 with SMTP id z17-20020aa78891000000b0062d83763712mr11440971pfe.28.1689567118771;
        Sun, 16 Jul 2023 21:11:58 -0700 (PDT)
Received: from Laptop-X1 ([103.235.230.148])
        by smtp.gmail.com with ESMTPSA id a28-20020a63705c000000b00528513c6bbcsm11705137pgn.28.2023.07.16.21.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 21:11:57 -0700 (PDT)
Date: Mon, 17 Jul 2023 12:11:53 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
Subject: selftest io_uring_zerocopy_tx.sh failed on VM
Message-ID: <ZLS/iWz+gF0/PGyR@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pavel,

I tried to run test selftest io_uring_zerocopy_tx.sh on VM, but it failed
with error like

+ ip netns exec ns-45iLeE2 ./msg_zerocopy -4 -t 2 -C 2 -S 192.168.1.1 -D 192.168.1.2 -r udp
cpu: unable to pin, may increase variance.
+ ip netns exec ns-45iLeE1 ./io_uring_zerocopy_tx -4 -t 1 -D 192.168.1.2 -m 1 -t 1 -n 32 udp
./io_uring_zerocopy_tx: io_uring: queue init: Unknown error -13

Do you know what's the reason? Should we update the test script to return
SKIP if io_uring init failed?

Thanks
Hangbin

