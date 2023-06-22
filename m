Return-Path: <netdev+bounces-12920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B173970E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9825B1C2107E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA33D87;
	Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174B3C24
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90EAC;
	Wed, 21 Jun 2023 22:50:28 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LJYs7j016592;
	Wed, 21 Jun 2023 22:50:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=Y75bt0Jx0wSsfTOjNWsZv8qJpJNCXq/KYo/Qcs4d6Dg=;
 b=Ie3ie29G85lkbJG08lFtuRS/E/mh48dnJDBBWEOjGIv5tQEs4eX5ystePYoZa4AQt4+L
 LbfgOG/Oy2VVgg9fk4jJLpDkCTwIlIAHlMloiG/s5/JLMzN+mohjOahGzmqDZG37XC/k
 tKsnVTAVGSpy1hefbxiYxNqkVpf8fM9eKmik0DctlsacaZYVjl5DqVUi+bOskx9HP0+Z
 V3Ru7gxGvW5EGORbS+HK1++uZ8fREKUfoNRwxBOgrL9CZBx1NJH6+8IrYdVFx+5lia14
 cAO3U3ICy8OCaCMKrjqFRik3WOtIcL9eyEW1qgEil5QE6/5i0VGeopmtoQemugohMvFU fA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rbyhq3shs-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 21 Jun 2023 22:50:10 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 21 Jun
 2023 22:50:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 21 Jun 2023 22:50:08 -0700
Received: from [10.193.33.161] (unknown [10.193.33.161])
	by maili.marvell.com (Postfix) with ESMTP id 00E573F7086;
	Wed, 21 Jun 2023 22:49:54 -0700 (PDT)
Message-ID: <98b9dc2d-9232-d0e0-022e-2e8339b3cb66@marvell.com>
Date: Thu, 22 Jun 2023 07:49:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH] net: atlantic: fix ring buffer alignment
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <simon.horman@corigine.com>
CC: Arnd Bergmann <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Arnd
 Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
        Nick
 Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
References: <20230616092645.3384103-1-arnd@kernel.org>
 <ZIxfK1MVRL+1wDvq@corigine.com> <20230620120038.0d9a261c@kernel.org>
Content-Language: en-US
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <20230620120038.0d9a261c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KHJNdM6_oMskMlKCq_KuaXUGSm0Dil41
X-Proofpoint-GUID: KHJNdM6_oMskMlKCq_KuaXUGSm0Dil41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_02,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hi Jakub, Arnd,

> On Fri, 16 Jun 2023 15:10:03 +0200 Simon Horman wrote:
>> Perhaps it just me.  But I do have trouble reconciling the description
>> above with the structure below. As such, my suggest would be to simply
>> delete it.
> 
> Agreed that the comment is confusing seems to be incorrect post-change.
> Flags for instance are overlapped with len, is_gso etc. so they can't be
> a separate 8B at the end.
> 
> Igor, please advise how you want to proceed.

I do agree better to remove the comment at all - it explains almost nothing.

Thats not a hardware related structure, so explicit pack is for sure not required.

Acked-by: Igor Russkikh <irusskikh@marvell.com>

Regards,
  Igor

