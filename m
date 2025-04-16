Return-Path: <netdev+bounces-183105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68040A8AE35
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 04:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC160190413F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E10190692;
	Wed, 16 Apr 2025 02:34:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE91624C3
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744770842; cv=none; b=UZzaGqUnq+uuCuFmFVGhJtH9vJBp8yX/DbVcVtctVkoIzpEVnz7q+kNDzSZOJqZ0VRvTPDZ1iMp+Imrqhc4OcRzNWF/wGJp6LFYhglhaHyHy7FUHJKdjOqHlxWMlBovdbAq6frXkhB4Y4oSqO5m9lglj06wLDoe23Lm2GVeoxpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744770842; c=relaxed/simple;
	bh=p/gF3D2asVW28tRtc0SWott8Z/qrZTu4tzNrxFmU0T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jW5yRiYWiwrA+YioDgfGWvZZ7e+hQIQ89U9+0NUhPeNSVfVRn6csSU7ImkGPQ0Jspu5pn8m+H4QYy643XOLxr+XQ7lBXPJwgOxRLUVh0a0b70JjW/VOAv+PHqRXhe7GqhDUILnPQ7elgWQ2Of2pgBsh3xItvhw8FZ90rv/IAQV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-05 (Coremail) with SMTP id zQCowABXlAwGF_9n3WpECQ--.326S2;
	Wed, 16 Apr 2025 10:33:43 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: kuba@kernel.org
Cc: chenyufeng@iie.ac.cn,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	krzk@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH]nfc: replace improper check device_is_registered() in nfc_se_io()
Date: Wed, 16 Apr 2025 10:33:32 +0800
Message-ID: <20250416023332.865-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250415173826.6b264206@kernel.org>
References: <20250415173826.6b264206@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:zQCowABXlAwGF_9n3WpECQ--.326S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYg7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAV
	WUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbN6pPUUUUU==
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiDAUOEmf-A3RO7QAAsZ

Thanks for your reply. I have added the Fixes tag.=0D
Fixes: cd96db6fd0ac ("NFC: Add se_io NFC operand")=0D
--=0D
Thanks, =0D
=0D
Chen Yufeng=


