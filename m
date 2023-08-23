Return-Path: <netdev+bounces-29897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D44178516B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B457281264
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8D58BF6;
	Wed, 23 Aug 2023 07:24:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECC8BE8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:24:26 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D088A128
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:24:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c3726cc45so2902227f8f.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692775463; x=1693380263;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WTqaO6kZcRzLug6Tf19WjfywSVMkwELLnlSRyjAmT8=;
        b=kLBup4D3ZGwdtO+9O58+zIouEf1aTOn1JXoT2Rja+rJXtjjk2EQwp3EncfMsyO8Wv7
         mrr4Umkc3xkIDBqlXUrsHXUzPFg4BLGR6s3c/3JIaNdesqKl3nNt20h+25q7lJNnBn1s
         Kfh/qVojNW9UV4hBZjWM7iTjJdrg+ssZw/CNR0jeztf/k9EH0wHdZvhSmsa6qF19+TR1
         FDW+57/Nw7+1iWvRI7pjlAmmaRnMi8y48eaUSYDL7aEB8zjp/m2oinwXbR7CCP7fUW5D
         2WKZZCWvCz9z/lmhLqri6qyDsThPubbvKlowLSGsb0mTO1Rs5JIbarJjsBV5xzG9ue8G
         LGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775463; x=1693380263;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WTqaO6kZcRzLug6Tf19WjfywSVMkwELLnlSRyjAmT8=;
        b=hW2GWpPdI+HkZ/vXhssStEzA8VnoDi0VN4rs/1xD+t3PhmOeDKE4g50E9UQnhXVTk7
         VuEKKfDkSMv1An55Dal3p83fGjJwk/isUSkM/+pgfCqgsAb4IrtrN3KUr5VNeQ6mceqL
         c9/RJuXuDfzYcjkd5RYuG1vBQz3qYXQRDJPHT8GDCN+GFHnVXww5k0IzWtPBAWVZGdWh
         IK2p53EZV9zkp9VrNfGJ0sXo9JO8xMX8QJSz7cEftB0Hm2VGtwHjpJY4Fi+6Jf2TthZq
         JQgzEalmq/MKoeIPZudOi4PxvH8iJr2YG9MFR5euf5dfpbMdBwl1Hzngaip3OQvWTh2R
         2yZQ==
X-Gm-Message-State: AOJu0YySM6KdXkkJmWTIRHuBcPWcyob+BPdeg6U/dVaJdT2dM8lfKEZ5
	Y5VQOyqygFNbkMCXD3TuoK0k7w==
X-Google-Smtp-Source: AGHT+IFWeSaGrv/qmVkcSWGdZnTMT+BHPHfZbyQxPWBUe3oCDzzm7oj9NsHDZjTcmd3kqLdWnrxneg==
X-Received: by 2002:a5d:6087:0:b0:317:6816:578c with SMTP id w7-20020a5d6087000000b003176816578cmr8690475wrt.5.1692775463263;
        Wed, 23 Aug 2023 00:24:23 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b003140f47224csm17975418wri.15.2023.08.23.00.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:24:22 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH iproute2 0/3] ss: mptcp: print new info counters
Date: Wed, 23 Aug 2023 09:24:05 +0200
Message-Id: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-fcaf00a03511@tessares.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABW05WQC/42NQQ6CMBBFr0Jm7ZhOtSiuvIdhUWGQWViaTiEaw
 t0lGPcu33/JfzMoJ2GFSzFD4klUhrAC7Qpoeh8ejNKuDNbYgznTCZ8xNxFFdWQ8kkPV3xS6AUt
 0WLVl5x1Z6u4G1p+YuJPX1riBxDSMmS3Uq+lF85DeW3yizX87lv7oTIQG2bUV+daVZeOvmVV9Y
 t0HzlAvy/IBUEqbuN8AAAA=
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>, Andrea Claudi <aclaudi@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=mrTQOYKjFM5k46RLNtxLCH35W5EqtHG3by5H9fu5f2M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk5bQkDiC0BczwhiPo9lr824TStCTVgvQTr5DvV
 qkKQNwGESaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZOW0JAAKCRD2t4JPQmmg
 c/v5EADAIkSvJfi/eRi4LlZhDT2YaMiTwiV5GL7eZ2Rdq8L5vCxNuzsH+jyG3r8eaADVIl7K3CW
 GPOdcce7KTDKHEZvhDXD01GxRA2X4WCt0S7ty3Eb97wE+wvbBunbLePFYxHDmVNkWDtnA1ky7cU
 zmVlv2keVFzsBV48QaNLdEeLnW5cZrA0yjUB0fLHa263c9pJMPdTUEUDeSXWH1RZQEPNSosqDWE
 IWC96NJzgx/2/bRObg7PnKw9RhqPBaeSWrct98gQYjegsUMZamYP9HVWuAEL3i3bWnP2eaz3QWO
 GjYlfPkLL6WHFIEtwsuc+pCEXtxZSD98DOPPNU5ZbKlii+zCrnejqIVjobP5+FKDSHFxCO2tEnR
 EK+rrPzX8gxVe9zTPwnSQeSOQYrq0OMOhmr2y9ErnTvUUiqlMXY/RgHjuagNvvqfiJi+hAx+wSz
 AE1HnwopsubRfPQTjuCx2tFKcbJttdE8XXs8mwqASRjFjbTMwZzRzg6HzZW0tTqRJEBmoOpuLwa
 D3Qyg6gBGEexlkLP1zxmXF8EhyGyPBoVQpcDfH+9HVnq2CrhF9JlDLyb8Wt258H9SHLAEf/pIgi
 Hpwpx6M3jo/7uChvP93iDv3TcmqV34FZ8PeRm0UgexL7E3G/4s4ZSy8jFBv4Ld13n8EE2ZEMM0Z
 huj0YYGs2xKDnlg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some MPTCP counters from mptcp_info structure have been added in the
kernel but not in ss.

Before adding the new counters in patch 3/3, patch 1/3 makes sure all
unsigned counters are displayed as unsigned. Patch 2/3 displays all seq
related counters as decimal instead of hexadecimal.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (3):
      ss: mptcp: display info counters as unsigned
      ss: mptcp: display seq related counters as decimal
      ss: mptcp: print missing info counters

 misc/ss.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)
---
base-commit: 872148f54e35cb13aa6c9e48e52306cd469aaa53
change-id: 20230817-mptcp-issue-415-ss-mptcp-info-6-5-9d6fa5121fb0

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>


