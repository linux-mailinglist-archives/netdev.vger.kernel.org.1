Return-Path: <netdev+bounces-180367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2C2A8119E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE281BA58FB
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7A23BCE4;
	Tue,  8 Apr 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OrAdb8Gi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE723A991
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127928; cv=none; b=GViSCavh3fdn2y2bNIAFXp4n6mG2Uh0D83O7EycPA2Bs5eYZnmDdhIigvcZvHYdZMJGfh3ypunZX471i+ygEi9wiFwU6ooI4VUecDRQ//g23FjFAA8R19At5L6ZeEIYB2Qod6g4taxsemc3sjFjArhlAvqj6n6LrI440Yl7AQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127928; c=relaxed/simple;
	bh=RWDIxjKULERd9rKieT1KlSktqFsibzwWfqHPe/4cIa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=p0/HGwXt2bAsLnAoBK8kqH7jyOh3ifd8r6bEGhp22YikviMQ9q5DQacvBnsBc/BPdaNQ01VzcRKwfTksWnNctvOFm4AvbryMO0vV8AaLZYxLflgA71R0zRUDQIStMIUcvqkPh6r7dV93mrtTAIexv0JnczCwPiwzMDe41z/lq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=OrAdb8Gi; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-85dac9729c3so381763939f.2
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 08:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127926; x=1744732726;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaVO28FUsf/+j+eVB0JXUktqw+0W3V93Ws76bANlpTw=;
        b=xNtF5eScKL8jml1WaNQnNOb1NJ4/QPSyb+9+sF9ajV3/AilOVIS1662shD+G4YwqJn
         eVVfXLcyRb+hAEmOPI18sK2r6GAlhGvm9imMdGoFtfPdVDCfX6RiceWf7jaUZCXidYba
         uG1pdl2F7M4RJACt9oSTTfTf6XEtYUTQpKFtzVdve9nKVgumKgiuL7qrYHPoHVoHhp7Q
         bKOchDOgImO84XT6Ov4Edp7aH7/Bkx8yfjUl5SuoeAKpt8s2YqQ5OITxBRYdF1xkLUnP
         rFN2wYxC/+v5w7aR2ruXVAdH0M2f5lQhsvW9jFJuId4VRJWbgIQfjxM+nA9tqeP2qbWB
         H1iw==
X-Forwarded-Encrypted: i=1; AJvYcCU7elAzTxnvuGS+xjV/1sz808v7Vq/aR9DZlwIJ6pLvGWmxEmeRVSKB6Yi1hgxUWstAZ4Whypg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzMIIVUcTJCF6KVId4Rf49Ty2iXQKgLqlifI5ZIGa8Dv9XajY
	z+F0R1CTCiBQ0dgPrfvIMqa/l9kasTlzNeMEFLQf8Bc3cLPcb/pFMaqUSif79S4n9InyDLsv6i+
	J8+zKn+wugnfjAgHwrW0v+oJ2TGbf9w==
X-Gm-Gg: ASbGncv11O6tYgAy7+bcT+7vjXexkleBTAE1pq/SbN9wj2pymeS+RDPqeIJqCz5mVUV
	YekocrJXvexn9t+Cu+4x9OEUa7qyOlzE3BlvBdJ3b7Xh0Cv/8jkc3673XYHDH4gRPmU+sZwuIhx
	3t5NN0P2IN4aeNnXEMPQhozXJ4daYe2e+pmutv/MYQlnyF/bw+F1JDhJ7AGkdFqaliVOgj6ndnI
	M63QJr2I3ksSTRvASotiuaOQWujSf+jRKA3D+B21tUZY5W3FunSn1r4U4hU8b62410Z+GcdWETj
	A+P+VAElEMB0esTN9HZ1w8uWCbk=
X-Google-Smtp-Source: AGHT+IEUKMpwu6G2eNbCLy7G2hpZnc7p/3gu0cXPUTvBdg3n05YEdQqhBspTylBX68cRhCoAQd3hqLSwSNn3
X-Received: by 2002:a05:6e02:1aab:b0:3d4:3fed:81f7 with SMTP id e9e14a558f8ab-3d6ec594cbbmr139695615ab.19.1744127925943;
        Tue, 08 Apr 2025 08:58:45 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d703b6c997sm1199585ab.9.2025.04.08.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:58:45 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1744127925;
	bh=jaVO28FUsf/+j+eVB0JXUktqw+0W3V93Ws76bANlpTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrAdb8Gi7kK42a9cG8OQD4nUjCJBGi3FAoNaKh8E2cXUj+0b3ObrsD39TrEIr8Pgv
	 K3rGJSm2AKRAHDr+BfxIR3xB1yps+6az/gW1yk8PJR8mSi5Pe+TXE95xk3pDKPAQMD
	 QaY5pqM0eq61PLuqJvFSMbSNqIO8B2+pPCgspfh5xbH/sPQqej0dYzxBoT9uGJ/HQe
	 8+wMntox3LmSshqP+t7fxT8Ul/9wilvWW8s29wlI0+YV+dSdxnGqrSWZrd/2DZcnKS
	 eGcg+waTMhSNxsbA9DdQpV8LYrNfq5kWyXYp9iTxhWuzgoQhqsX9pUgq0Xls9nCbig
	 QCYIX+BOAtxCg==
Received: from mpazdan-home-zvfkk.localdomain (dhcp-244-168-54.sjc.aristanetworks.com [10.244.168.54])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 0C1B610023B;
	Tue,  8 Apr 2025 15:58:45 +0000 (UTC)
Received: by mpazdan-home-zvfkk.localdomain (Postfix, from userid 91835)
	id 0560440B1D; Tue,  8 Apr 2025 15:58:45 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Marek Pazdan <mpazdan@arista.com>
To: kory.maincent@bootlin.com
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	ecree.xilinx@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jianbol@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mpazdan@arista.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	willemb@google.com
Subject: Re: [Intel-wired-lan] [PATCH 1/2] ethtool: transceiver reset and presence pin control
Date: Tue,  8 Apr 2025 15:54:14 +0000
Message-ID: <20250408155844.30790-1-mpazdan@arista.com>
In-Reply-To: <20250407153203.0a3037d7@kmaincent-XPS-13-7390>
References: <20250407153203.0a3037d7@kmaincent-XPS-13-7390>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On  Mon, 7 Apr 2025 15:32:03 +0200 Kory Maincent wrote:
> ETHTOOL_PHY_G/STUNABLE IOCTLs are targeting the PHY of the NIC but IIUC in your
> case you are targeting the reset of the QSFP module. Maybe phylink API is more
> appropriate for this feature.
> 
> You have to add net-next prefix in the subject like this [PATCH net-next 1/2]
> when you add new support to net subsystem.

Thanks for review.
From up to now replies I see that there are concerns regarding usage phy-tunable ethtool
option for this purpose, so I will post updated patches after we clarify proper way to go. 
I need to check more on phylink API, from the overview I read:
"phylink is a mechanism to support hot-pluggable networking modules directly connected
to a MAC without needing to re-initialise the adapter on hot-plug events.

phylink supports conventional phylib-based setups, fixed link setups
and SFP (Small Formfactor Pluggable) modules at present."

I don't see QSFP modules are being supported but I need to verify impact of this.
As I mentioned in other reply this API should allow for transceiver module reset 
from user space if orchestration agent detects transceiver failure state or when
it gets direct request from Cli.

