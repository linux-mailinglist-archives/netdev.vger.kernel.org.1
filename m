Return-Path: <netdev+bounces-57254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E809812A30
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447031C21486
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 08:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391BC171A7;
	Thu, 14 Dec 2023 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLDu/6qq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EEE112
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702541999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRmYmYKdouaq3SuesAh37kIKzoyNX5WPg71KEcwVJ1U=;
	b=ZLDu/6qqoYFuOiSUXmwRisweFyNToeXMk1LKrZnrzJjipFzYiatNQQj9r58C0at44nNiR/
	2jYAj4GCEU4aOTSSu039PX4YEVVjV/0m+ALhmC8W74BMeQVXK0QGaufN4OzAR8NDRPvDaW
	HcFwLT83jPMemY5UNyJwAQ4P8WOuJb4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-CWOdk0DHNKWLKPv08Ey-lw-1; Thu, 14 Dec 2023 03:19:57 -0500
X-MC-Unique: CWOdk0DHNKWLKPv08Ey-lw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33637412100so1317971f8f.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541996; x=1703146796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRmYmYKdouaq3SuesAh37kIKzoyNX5WPg71KEcwVJ1U=;
        b=tDwC91l8EVK8LGB1V01OrEkX9+Kwz7YEHiPPzCs2C188Rp1jz96QjMi1s2K/qNxUIa
         Xe/ZnZg13fIfpqWrh4WTLmOsdqArqaRSncjh1buUPTdvoYq2WZWCAsEOuI6Npj42TLI7
         QnWP3ebMANzLJ9ehOup4NMrc8cmF4PHuKwL9hDstgRlzIht9ZVaDahwtysCDiXEQgA3W
         3V/enRJjbVVXSDjuhfkoK5z/omOFqAkswNV/8C9Z+mc/duR2B55+VKl1/Irf/Rz6Lt4m
         7AKpXqkkdLj5oTifLlb9P1i6/p/+SIEl9G6t/y9SE7XPX7FgLOlzD6rUx+cbPKlZm6Oh
         ifrQ==
X-Gm-Message-State: AOJu0YxKa0nIjzLMzhcus/h6i0OVON4lwQuZTJWhkN5ZKoNbQ4ORSSrG
	qD6/gogk7Pe7hIblgekGDs2B3RGijpnKLmM+3xcq1zhuJIUkDfo+PA4RFWM7Bjr2D1BRsl0aKHt
	TY0iUtxFByXDxJ+FX
X-Received: by 2002:a05:6000:1c6:b0:336:4297:b25d with SMTP id t6-20020a05600001c600b003364297b25dmr957847wrx.136.1702541996581;
        Thu, 14 Dec 2023 00:19:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdqvpfAVvf4U6RhyJKj4ac/lPlURzo1wv0qRFNbYaFyfMUYKbpbf2LJr5fGeJFUOmj7q8+yw==
X-Received: by 2002:a05:6000:1c6:b0:336:4297:b25d with SMTP id t6-20020a05600001c600b003364297b25dmr957779wrx.136.1702541996175;
        Thu, 14 Dec 2023 00:19:56 -0800 (PST)
Received: from sgarzare-redhat ([5.11.101.217])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b003363823d8aesm3920736wrt.59.2023.12.14.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:19:55 -0800 (PST)
Date: Thu, 14 Dec 2023 09:19:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Marcin Wojtas <mw@semihalf.com>, Russell King <linux@armlinux.org.uk>, 
	Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	UNGLinuxDriver@microchip.com, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Jassi Brar <jaswinder.singh@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next v1 1/4] vsock/virtio: use skb_frag_page()
 helper
Message-ID: <nfhefym2w56uziqgzcloodvtf4wg74skoskhi6dztqqnlabhis@h4rj7p2ivvej>
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231214020530.2267499-2-almasrymina@google.com>

On Wed, Dec 13, 2023 at 06:05:24PM -0800, Mina Almasry wrote:
>Minor fix for virtio: code wanting to access the page inside
>the skb should use skb_frag_page() helper, instead of accessing
>bv_page directly. This allows for extensions where the underlying
>memory is not a page.
>
>Signed-off-by: Mina Almasry <almasrymina@google.com>
>
>---
> net/vmw_vsock/virtio_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index af5bab1acee1..bd0b413dfa3f 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -153,7 +153,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 				 * 'virt_to_phys()' later to fill the buffer descriptor.
> 				 * We don't touch memory at "virtual" address of this page.
> 				 */
>-				va = page_to_virt(skb_frag->bv_page);
>+				va = page_to_virt(skb_frag_page(skb_frag));
> 				sg_init_one(sgs[out_sg],
> 					    va + skb_frag->bv_offset,
> 					    skb_frag->bv_len);
>-- 
>2.43.0.472.g3155946c3a-goog
>


