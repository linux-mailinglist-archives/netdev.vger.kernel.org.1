Return-Path: <netdev+bounces-38189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F17B9B5C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 09:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 61C491C20856
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0231453B9;
	Thu,  5 Oct 2023 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSp+iZgB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA97F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:26:10 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EB77AA6;
	Thu,  5 Oct 2023 00:26:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32329d935d4so621809f8f.2;
        Thu, 05 Oct 2023 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696490766; x=1697095566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AGYYSttdjbm4Vxe6u7LT5aarQ17DelLXBIN0Cg3r5h0=;
        b=gSp+iZgBL+GY5YKW3bfrLjpntaDeEO+0qhTN2KY/OydrdBKBLu3WO6PIyav9HxkjQd
         eFeFRM62rAsXFVA+S4A68kY+hIxr/Q5fWL3hXLQ17S8/pbwjtxrtpY3W7HAjWleka584
         t/auVaCI6k+goMXWoAq2bUxjQmIuEXNBt+defnMzY+VQHfTfWLqG+Dz2NfbIMl1lNrMb
         sx+fh31TU3nWV9qGTyHBrVgd7UKftqbpDi8ZDPHOgsZTljQZXtWkfzVh0CGcMXBW5an4
         ABfwZGwvO8EaEVoJRER5gRx7s3TyiS50qDdmOIS81CHpdkdUJfbz1aXFW/FHUZDkZt8c
         Fn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490766; x=1697095566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGYYSttdjbm4Vxe6u7LT5aarQ17DelLXBIN0Cg3r5h0=;
        b=TmaLEYD0y4EpUzqBiCOD/AEHTBmK36VzBeZGNnuQtLreCJGjWsqoX2bCV5HGCzvaMu
         /82+hpiRPdn9mkQmEc07+d5efSyuJdj7CD9NoA7caA6oKQC5NlAGwBfEW69lAjrwYvuu
         5APVNKJ1/ZiELlpIZyuAi2QpxApIEFKrMBXk8mfFbRTbZSu7TyCEAXFyMoS5KyjmM3up
         epOak/0gW0+BoDaCt0wyK4dGssCcAmV7OPFRFJCJd4RHT5ofiB81uxXDu18AePfUK4Sj
         G9egCPHCujJMVc4wmDtJ3mfRd7mIqteObOZGA/iVH+fF/2hPtzeLmdJguLmNHqJLgsLy
         Mgxw==
X-Gm-Message-State: AOJu0Yxq7IceECszt+PfD3XomiqitSC483Bi3+F9kM0qp+f3BO/EP3cg
	9gwffayZdEZ66RGyUNs4mcuuwQ3rexEAzluXYVM=
X-Google-Smtp-Source: AGHT+IFOsR8bcDAMN52/cj4X6a3+o51XI/0aWe2O05i8XzyO1gLayHsWVB5H9d49ZRLb/znFkUaNAUvhg71omLR3Rxo=
X-Received: by 2002:adf:fd12:0:b0:321:4ca9:ee86 with SMTP id
 e18-20020adffd12000000b003214ca9ee86mr4214908wrr.53.1696490766088; Thu, 05
 Oct 2023 00:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926105732.10864-1-dg573847474@gmail.com> <20230930161434.GC92317@kernel.org>
 <20231004105317.212f1207@kernel.org>
In-Reply-To: <20231004105317.212f1207@kernel.org>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Thu, 5 Oct 2023 15:25:54 +0800
Message-ID: <CAAo+4rVuwAsJ=mr8u3tG5XdwBzY_QQ=G4UkA3nxkB_hux7581w@mail.gmail.com>
Subject: Re: [PATCH] ax25: Fix potential deadlock on &ax25_list_lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, jreuter@yaina.de, ralf@linux-mips.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

No problem, I just sent a v2 patch.

Thanks,
Chengfeng

