Return-Path: <netdev+bounces-57173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7260E8124F0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5761F219DF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5907FD;
	Thu, 14 Dec 2023 02:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvhIQC/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E504AE8
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 18:05:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbca591b8deso3965467276.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 18:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702519539; x=1703124339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzTXKjA5KWsaYAjqKhDbOIpqWzWFT9AS368JXZ2MRs8=;
        b=dvhIQC/v1AHHBiu9xhrWi4kRmfpWMCzJe4P5d7bNTHkaEX/Qw7QPHgnupS2yzV1Ca6
         65rtV+JwRqEnrclvbw34QOSyjJxt76awp7bgZTZmjNT74uxiopeWERjDxZEksP540jFX
         GCA+9GUSCr7ZRwCX03Nd1GUYiKKLj2IIZHiQJP6GlNIQMBVdSjUWp+HzDF8n4byMRohe
         l7IMSOTHQSFM5q7BoHS+SwbLYc9SzcANV2njO7MSHovSofSXzA8sQW6gut83NShKcioj
         g4OHMyif42YSMQysGddkTrRUGw0RA4XT2HZQR1i4ZAObE5pcSziEfhTUUOU7xfns0eCl
         4JdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702519539; x=1703124339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzTXKjA5KWsaYAjqKhDbOIpqWzWFT9AS368JXZ2MRs8=;
        b=A1DjpcddnTmYJQ09NKNqZgoiPiwIkAmLfoeu6F602aqzhPbYl40wLA/0E59bsFYKjQ
         w55MMmSZmouWV2uvkya0j4fb66mnTipFhnkXqY3wkMNWOxef+qWM+AO2eHtCDTNhWcZl
         +MoooRGeNTzA9CLToKD12byPP50uS/PxBhIZuKI/jNqP/kp5g3cTcLkls0gxKBy80+oR
         v8nglBQMXtEVVLeHL/mTCpy5Pj93MzJkuN/HGQ5eL4tHX/89OAVt551oRc4fbm5TUxhJ
         LqWDDxy+IbzXma5IVsEVQoiF8xZMWhCHUWh6J4GPywf8HItmTcDFvstbQxshVpkvhOLF
         vA9Q==
X-Gm-Message-State: AOJu0YwaPoh3BHg2L9MojtazHwirSLNO9Zn7wASFp+66s/Atpe0onJKn
	ZinII2fW48B42qev8DcxSeMHJGjdSnXIKfPCag==
X-Google-Smtp-Source: AGHT+IFvXUPRVjinne3eyeqMXrPSn27B36v8rluqCbSKO9WAxxureBDR9DLVkSWnv3Loqa1nvhzoL2hhHQkqKHt9JQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:d31b:c1a:fb6a:2488])
 (user=almasrymina job=sendgmr) by 2002:a25:abeb:0:b0:db4:5eed:8907 with SMTP
 id v98-20020a25abeb000000b00db45eed8907mr77688ybi.8.1702519538827; Wed, 13
 Dec 2023 18:05:38 -0800 (PST)
Date: Wed, 13 Dec 2023 18:05:25 -0800
In-Reply-To: <20231214020530.2267499-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214020530.2267499-3-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 2/4] net: introduce abstraction for network memory
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Michael Chan <michael.chan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Shakeel Butt <shakeelb@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add the netmem_t type, an abstraction for network memory.

To add support for new memory types to the net stack, we must first
abstract the current memory type from the net stack. Currently parts of
the net stack use struct page directly:

- page_pool
- drivers
- skb_frag_t

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for compiler type checking we need to introduce a new type.

netmem_t is introduced to abstract the underlying memory type. Currently
it's a no-op abstraction that is always a struct page underneath. In
parallel there is an undergoing effort to add support for devmem to the
net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.com/

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 include/net/netmem.h

diff --git a/include/net/netmem.h b/include/net/netmem.h
new file mode 100644
index 000000000000..e4309242d8be
--- /dev/null
+++ b/include/net/netmem.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * netmem.h
+ *	Author:	Mina Almasry <almasrymina@google.com>
+ *	Copyright (C) 2023 Google LLC
+ */
+
+#ifndef _NET_NETMEM_H
+#define _NET_NETMEM_H
+
+struct netmem {
+	union {
+		struct page page;
+
+		/* Stub to prevent compiler implicitly converting from page*
+		 * to netmem_t* and vice versa.
+		 *
+		 * Other memory type(s) net stack would like to support
+		 * can be added to this union.
+		 */
+		void *addr;
+	};
+};
+
+static inline struct page *netmem_to_page(struct netmem *netmem)
+{
+	return &netmem->page;
+}
+
+static inline struct netmem *page_to_netmem(struct page *page)
+{
+	return (struct netmem *)page;
+}
+
+#endif /* _NET_NETMEM_H */
-- 
2.43.0.472.g3155946c3a-goog


