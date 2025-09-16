Return-Path: <netdev+bounces-223428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A5B591EC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870BC189E530
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5653928CF6B;
	Tue, 16 Sep 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VBF1AMGG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B719E23D7E3
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014307; cv=none; b=UFKipV4tlZjncreWVNdrYfXArbFd1tYrbiDgmcoAd06vwr1lIpvIZef9dTZMgm4jSw1VTZ/qYhYcKn6AA5g4jEVTYf86TYn9Y/R9A6VKuIHM+vOGMjxCyXqBNaRIy7xj3N0CYT39NZj51Br17hqz3u5Q9efizIIMgTkvw2jyifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014307; c=relaxed/simple;
	bh=zwsqcK1K8I4g/AxL5eYHfhv+amNKbZVGOpz1wTaG/sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D91ZECq/INM1NIkXsd6M+VFrldQ4W/v5tNBMesT27WxQBTSQB2AtOpr58/JensX8z6GGgAs3R0lwUUkKO3lRvnmywmVF9N6oy8o11Ml2K6s9YBBSt3qGhxC+w7OArbWXjejVrE9Nby1SowW+GFWeiybjlgGExgSZ6DZmWdGEs4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VBF1AMGG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3piir019564
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yU38SlnqFnK1dl0OwtvhRawH6vqrbBs2lAUw36iIdE=; b=VBF1AMGG0FRsGwk/
	pu6T9o3wg+JBFYIYurwRbfBzv0GozQATJqDpJ668K1f/FNRpalYYuuhOooOQi7b5
	HHVOE+J7z8FxGOT5DHasut3A6hnjMUbe323x8mht4frVnhYATo+lbSKhdBUzye+4
	rri6KW0Aqb6H8tv/Zwy65NiZomWSwnhTifo84PWC4+wrtnZrm6Pd2fYIEzUAPSk6
	/bgSa0leLh7qK85S3MvqOo9SfCTa8GPlT0Feuaf/EgoMolrlkKRoDOAehlce0Gp1
	arP+S1TFvDAOlyKkE/PCxQTnquF9LyYHQPnsTGLFu5WvM50dgMaRk6MaX79SdXex
	G8PCTg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma89yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:18:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-252afdfafe1so55682275ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014303; x=1758619103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yU38SlnqFnK1dl0OwtvhRawH6vqrbBs2lAUw36iIdE=;
        b=qSICmMkNjUMyt73G4F5J8SnjheIqGElsE5huuMJzmMIcZeIntk5+CjLt1XvU3POdIL
         7dvXV5LxeWA0QRp4RX/lGkmVvy23OkrCN0revdL6QJkDxHFfwIKZcwOx+x1USMcdIolJ
         gDuAcegkrjnVce1LCZkDKCdnkowIWBS0JbOnJdMzon7zxjGr7k0UvH6ivw9MmpO2BSkO
         hFZyC7lbdXz2mSi+wJehtTr72HUuWrj1i2ENRCNRMLKGzRC+yYLH+RRrapPMzmTbDpWn
         rE5O60kSoOFKUcj7O0AVi0XbzKWgM3Lp77OjWzYAnj36SCegrb20g6Gy0xppH5r9GDN+
         TPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnouRDT/pVEvOHurITFauyssrMyzg8qwVh8kPqOpieGenxD75ClHGnBJsHphRypzHJUQkl594=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkLYZ5zzKrwzvwF4W686Ag/ZJWTsHd5x/lZ7TmnSZOo4FFVAm
	zDIRA+wZzn7eu0VeJGvh3O2TG2psKFNy9YHJoH02nWyTAPf2ivbmhmYfpZsEbcOmes3OEumbwWk
	PPkI5A3jXRSBjrezNXjsuGmrhqleJh+ImsJhCc/nwa+fJYU2TOudxd1bTISZw8RRotT4=
X-Gm-Gg: ASbGnctq4xjhtuxJ13E1KH14hxDksY3a5LKNAD1hRWoomIJvmCwkzMR21/HM0DIyiaW
	jI+eqFaF5tBH/lAxVt5o8hHPanz5wEZQgwtzJODpXrTj7gph3rK0JU++0OIy7YlNmZHOMjkFICb
	JIwgJYdgDctWKJMK10PFxmotXVR78Y0ZpqsvQNX3uQaPdInUP7N9nw6rHfOes3piKQo986ImwE8
	P+yxYoz24K1pks+lJkMlpD0d8r+zrgIvJ8HATbQ0KtBC0PonLdhmqsCNapvSQCrWejQyXVh846c
	aUlcUVS9R1eaka47uQbRNy09O+f22jb+BnnHlxiEm3dAyJCVq0k6TKVk7ku8d98vKO8=
X-Received: by 2002:a17:903:166e:b0:265:44ae:d24 with SMTP id d9443c01a7336-26544ae0f0fmr109025335ad.43.1758014302993;
        Tue, 16 Sep 2025 02:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUTp4KmbKb6w4ICddFjxV1wTcHyF4t8EHj7cMp3vuJ2wqlH26j9yp2DgzTArzCXUUfH1i7TA==
X-Received: by 2002:a17:903:166e:b0:265:44ae:d24 with SMTP id d9443c01a7336-26544ae0f0fmr109024895ad.43.1758014302506;
        Tue, 16 Sep 2025 02:18:22 -0700 (PDT)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2663f6337b3sm56192015ad.102.2025.09.16.02.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 02:18:22 -0700 (PDT)
Message-ID: <0b950a45-21e5-4c8d-bc76-1c801b86e2ef@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 14:47:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] bus: mhi: host: mhi_phc: Add support for PHC over MHI
To: Jakub Kicinski <kuba@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, taniya.das@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
 <20250818-tsc_time_sync-v1-5-2747710693ba@oss.qualcomm.com>
 <20250821180247.29d0f4b3@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20250821180247.29d0f4b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX6+7s3LjCf/31
 a77qiYJ2vj2JHgYpgZU2CY1ZfJWicLgQ5n1DOpHizGKJsNWRDl+qGaxW1llsEDEbPCN4tIbvWFU
 T1L7fS5tN9rjySoyDEFKCoeuDrsdpadccltY4k/2YOa/+TBLszkxKLqlP/gV7nUeg9QdjD+ARy6
 YNEsYWZbtoOd1nnWWGlzxccY2QmQtNpg4wwt4hemOyvAMVXH2mxIh0dEtWQvdG2Kv38pQnzrNPi
 cHO9Yf0l5tJIRUPRD9LprhRHbFhyqPGXK8/IuS0dVseQiJfTk+ijnad9C2/b9q5b3TLNCkl4Ktt
 itngq1w2o8XRQQPNDpFiQcuamCLKVzDEkefLm1iiw2dXPIJXWYbDOAVEA4Iy5o/WdrO5LgetZx/
 nr92dPVL
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c92b60 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=xLYDFgVRoUo0Dj3B0GAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 13jczAO4jqXUR1vkpc0fSht5u421SyM4
X-Proofpoint-GUID: 13jczAO4jqXUR1vkpc0fSht5u421SyM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019



On 8/22/2025 6:32 AM, Jakub Kicinski wrote:
> On Mon, 18 Aug 2025 12:25:50 +0530 Krishna Chaitanya Chundru wrote:
>> This patch introduces the MHI PHC (PTP Hardware Clock) driver, which
>> registers a PTP (Precision Time Protocol) clock and communicates with
>> the MHI core to get the device side timestamps. These timestamps are
>> then exposed to the PTP subsystem, enabling precise time synchronization
>> between the host and the device.
> 
>> +static struct ptp_clock_info qcom_ptp_clock_info = {
>> +	.owner    = THIS_MODULE,
>> +	.gettimex64 =  qcom_ptp_gettimex64,
>> +};
> 
> Yet another device to device clock sync driver. Please see the
> discussion here:
> https://lore.kernel.org/all/20250815113814.5e135318@kernel.org/
> I think we have a consensus within the community that we should 
> stop cramming random clocks into the PTP subsystem.
> 
> Exporting read-only clocks from another processor is not what PTP
> is for.

Hi Jakub,
 
Thank you for the review and for sharing the link to the ongoing discussion.

I understand the concerns about using the PTP subsystem for read-only clocks.
The idea behind this patch was to use a standard interface for syncing time
between the host and device, and also to make use of existing tools like
phc2sys from userspace.
 
I have looked into the on going discussion you pointed, and we’re facing
a similar challenge. Based on internal discussion with the PCIe team, we’ve
confirmed that PCIe PTM isn’t applicable for this hardware use case.
 
That said, since it seems the community prefers not to use PTP for such
requirement, could you please suggest any other way to support this time
sync requirement that would be acceptable upstream?

Appreciate your guidance!
 
Thanks,
Imran

