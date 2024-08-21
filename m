Return-Path: <netdev+bounces-120552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48848959BE0
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2631C20FDF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A103166F04;
	Wed, 21 Aug 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQyAf9pV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A391531C1;
	Wed, 21 Aug 2024 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243607; cv=none; b=ngeZoyZVn46qneihGPjBq66eHF3Ub+diprlCkCJxvbaGJAk4hwk/goq9b/WXnRQfITAlElH57GHtXQmBKQAzqAGs0GD0HTm5IENX3QlwhhmclWe+1NJD1/nIL3kdRLC/OnvG/leA6a6nCM4YWdy4osiyNGsk2w6viSpFmA8PYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243607; c=relaxed/simple;
	bh=OymAE/ZZBR4mv0HhBIalO0BOicWD78n6nDWqYyMqynA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ehmmvrM9jyxfIq9A/10WbADM4xRHLlUkAU8b2/vRt6mGQTNFqtHvqN2JNjF+1oEuoU+JjlupCgSrfQafie0SKAnVH1i7EmqBW8R673q/nQRMDzNp1NbhXra7CEE8DFd4k2aQxSTaRqzb0xdfQeNVDMxzcE7pRtoaSuE+pJYX2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQyAf9pV; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-201fba05363so46063705ad.3;
        Wed, 21 Aug 2024 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724243604; x=1724848404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38LzfASOFmg17IvE+tEedmZUU9vVFKl4gZEqe47LcGA=;
        b=HQyAf9pVjfNcfKn3cOL0X3eWQmltQG70t5Mnq1AB9BYmAorUz1cS8+ajdtWJWFuJhS
         yrv94/hoWucVgXDW+ODS/0/VlglveV005FE+acUxpDjHZq0+XwlQUGtbDmP0XRmOdsml
         hFvAbzdEX3SwNdlNv6HbX+HgEW7uUHIkWwThjIV3O6NqQhvrxGWMqz7oqQtI3xIR+zpj
         BjSuV6Dvt05yp346t2yovBiFhvV++v/D3zjy5FS4yrGJg6P34b6Cq2eGy3httssDrb5J
         xNAcqTbcGbx8sCDuc3g/hT6UGq20RlVJndJJo3ZT4S3p8ni27JdVh4kx/PW7742ATOlv
         g8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243604; x=1724848404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38LzfASOFmg17IvE+tEedmZUU9vVFKl4gZEqe47LcGA=;
        b=jsoVNIofyXzlYt2U8iNQp4DUcOuYO1uVdD8cMvQIco2gvuJZ/iN/8dqWOnpK+vSKpT
         ERofg2gOsSmFlgy92TV+tqE6VRQCWM11i6ucEfFvUU8XRID9y0gbTziLCnxDlqhcDuEg
         EgTBSukLKc+RFD4dYDcN5TqNKJhTUfuRaPHQFtoipg9fDCVcKIrUDdg8FV9G60krDZK5
         ME5z5maOFyOfgOpU8/BBxBetl/VexY7hVBnPH6LfdRGzHu20SffYPxoNINzABIuv0m+0
         8/ev7We9wdyfeIiOeO1svWbmod+CI62cb7pgIBrsSKdUME7vIAtuKQIhSCUiSV0Rg8ok
         ZT5g==
X-Forwarded-Encrypted: i=1; AJvYcCU62T4nGH0LHVPjeCh0hr10rMotYbjIUmHdcxNDTm4wAZ9mhf9UCzpIRWhRdIMfgU5ccRwKeo1rW5iFMMM=@vger.kernel.org, AJvYcCWrzvLelLz9RUe0NX6vQQ+lBVl3Dj/Zep+zSpT2q6lgAyBkyHxly+SZ6qY7ywDfTyx11nBZj8rN@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKaRYJT4XGaKBaBRiDGkaMsm7h0gZuetyXS+z6O8fTI9Bo4B5
	zq5xnnND4lMv85fv+wn+npUzKaAGXPQKkUEVVPiwj5Tm9gn87TFc
X-Google-Smtp-Source: AGHT+IFOmUSISQmx1QZwKATxecp9bbNULKQetnFCCRoqRL+BE/zW5AmnieetnrrBmOwR66LzoJOLNg==
X-Received: by 2002:a17:902:ec92:b0:1fd:93d2:fba4 with SMTP id d9443c01a7336-2036819f4bfmr20217855ad.48.1724243603576;
        Wed, 21 Aug 2024 05:33:23 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375631sm92534605ad.154.2024.08.21.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:33:23 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: pshelar@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	amorenoz@redhat.com,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH net] net: ovs: fix ovs_drop_reasons error
Date: Wed, 21 Aug 2024 20:32:52 +0800
Message-Id: <20240821123252.186305-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is something wrong with ovs_drop_reasons. ovs_drop_reasons[0] is
"OVS_DROP_LAST_ACTION", but OVS_DROP_LAST_ACTION == __OVS_DROP_REASON + 1,
which means that ovs_drop_reasons[1] should be "OVS_DROP_LAST_ACTION".

And as Adrian tested, without the patch, adding flow to drop packets
results in:

drop at: do_execute_actions+0x197/0xb20 [openvsw (0xffffffffc0db6f97)
origin: software
input port ifindex: 8
timestamp: Tue Aug 20 10:19:17 2024 859853461 nsec
protocol: 0x800
length: 98
original length: 98
drop reason: OVS_DROP_ACTION_ERROR

With the patch, the same results in:

drop at: do_execute_actions+0x197/0xb20 [openvsw (0xffffffffc0db6f97)
origin: software
input port ifindex: 8
timestamp: Tue Aug 20 10:16:13 2024 475856608 nsec
protocol: 0x800
length: 98
original length: 98
drop reason: OVS_DROP_LAST_ACTION

Fix this by initializing ovs_drop_reasons with index.

Fixes: 9d802da40b7c ("net: openvswitch: add last-action drop reason")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Tested-by: Adrian Moreno <amorenoz@redhat.com>
Reviewed-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/datapath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 99d72543abd3..78d9961fcd44 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2706,7 +2706,7 @@ static struct pernet_operations ovs_net_ops = {
 };
 
 static const char * const ovs_drop_reasons[] = {
-#define S(x)	(#x),
+#define S(x) [(x) & ~SKB_DROP_REASON_SUBSYS_MASK] = (#x),
 	OVS_DROP_REASONS(S)
 #undef S
 };
-- 
2.39.2


