Return-Path: <netdev+bounces-245124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D34CC7450
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 12:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 895553034D7B
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C4343D63;
	Wed, 17 Dec 2025 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aaREKqxM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QPU3bTg2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360E26B777
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970073; cv=none; b=VqHgXLW1HPnSrFWWfOod1D/bDOCFjhsUXWFmvPPAGyRLqyT0J543G9SpRZlBnOqSESCJAwBl44nWLzI+ZTpNCgliMASZcqRTYiKVGGPf2BrNqgJEsxfz7urMHsum8kSCcpAlK1w1xPO4/nbmCYDsbkWCOoKBbmSF6KnP2m+yfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970073; c=relaxed/simple;
	bh=W4Dfoa0Zy3S4AxCEy+p67et+4vxon9hCZFRzjz9WC+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPDKAPFxBDhyS9ehAS9LCO8JSfC95qdeNKG9tx1HGaFf2Vnc/CZLu1XZMWSqRcI+4L+uhTQ2JzzYYI/44oRhRdVPnGmlD/qEJflDlS2gkmf17FX0HmT35OQqoQaR9sA0wWnMLrQH9dO+GUkPVEjhnYj6rx9Uydpmd6o8Mcw7Im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aaREKqxM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QPU3bTg2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHAutlH2316155
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 11:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xI03PECydTE4oWk9g5Kpl+k3sm6xi1SX0uIXywZqAmE=; b=aaREKqxMlR0CKTA8
	482s3ri0thBaN4gcebpLZMyfVFMB21q84h4d60AQbZdOa/sSlkUp5z0Y5LU3kO8y
	gV/uNmif59BZjhMNBgbokC/RWFCZ0w34OAH57VF55fWYoizGWvUyUAWgc0d+VB19
	/1USOsPZ2bZ7yhMSaxAJWpDgrOc77SKxTSvVkgyV9fz+7REVHAuJPFW7FoX1yKy2
	3CRgRruNjm5cn0yL8rY1BxokFHmUvjUWYs1eQ3+FfeiMeDoRFnJ1mRZf+KqqaoZ1
	PxTu+EWifhLt9tnVPqSTKrWi1zWsTdRs0T4cUcxJiqzChCzrRcbqg084SgqCep6b
	JShZSA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3nkkh8c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 11:14:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7ae3e3e0d06so4792827b3a.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 03:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765970068; x=1766574868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xI03PECydTE4oWk9g5Kpl+k3sm6xi1SX0uIXywZqAmE=;
        b=QPU3bTg2gWuCUWbnFA2X/28i7af2jeV/Z3HjZOE9iaTBSbbDx22QOXTr1TSumZ/Eyg
         v6kWG6w3C7vwUGtyZLWyYDLHT/j2n58kzjoGFGkcvhCt2pExdr6n2e555a/taQlcorzL
         I4kSVFmuPDZVBNf2JbpUWsMCe++H0RUSuoifG6rHq2dsYVIflxYt4B+NG/1T5iQpXaqi
         BljYvoWd7yyrM3d6KO6d4u50zZ3WW52eC0/PdAQBCUUWTJb6lNb+X0JtoZI4Py1jdmbo
         0flj536nJJKSfQ7hvc3i+OWDrX2Vr3v0XbsWo8w7FJLWi2pn7V+/wQI3Oz+KUaFOpuHz
         KjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970068; x=1766574868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xI03PECydTE4oWk9g5Kpl+k3sm6xi1SX0uIXywZqAmE=;
        b=dlBZHbtp6FxEPZvQ1GCKvw/vWjA9mjI00gvCDdPJmJ+5fYusduwv/787qDaTTlz8OD
         EG7DKkrZp2sSy1n7+pTXsDX31lQcDUKThum+K0Ry5AGXaCf3Wv7OMC3W88zwBDsbUs6U
         Bbah4AX8s54Clmx9aUNgKx5/CPfgtdjTdxYQDkQsxngI+t5y1Hx5wW6g3yofg6OVevdS
         SGnnlk32MGkLoYwBuQhbsTZMr9uk3mlnDfEsW5Zg8uBdIzd9pibnpeWX1qJJgUdby/ti
         QcixRacYyUoPHYMAC1wGYUkYQJ89EUGCGKEqts9SZb4eCUaul7gwUgeVYMlLoDJJhhAa
         Zg6w==
X-Forwarded-Encrypted: i=1; AJvYcCWW07NQpEGr82poBxjxdQpQsa2mn6GWJ8K/bPaN59j05lnwokYzHJ9Ny60MBBCeSjZussUVHVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+oZx7lyBHA5Xicw9w7nemqwsG1Gf6FmNMtXXGSFQDYfTfJ1S
	9gEoyEEOBsS4bUtRVXnqZCybzlgkZAjPGkDGVLdJCXhVfCOGr2KLotfM7WmycHaOdEQL1httyKn
	y9mCpFTCeIssoktaGdeDCCcXtaxlMCmSzGZpneZgDY9gxjP9u0Lx1XDDxvoU=
X-Gm-Gg: AY/fxX7lSI7ZaCTYR1TWQedPx63OAl6lLk8RoaGO66yu2J98g9JKx6LKAuegiJvam8I
	LXZnhtgFbkMHiQPVPtcFEjTOxNhq0QOJ8WPB22MiNRZfM3slZIFuubpJOPF67Qw2BF2s2gT23tO
	xU+6NoemJvyYeFsfbyQXlrFCT2LV24BVZuSFx9WS4sFvnz/7TGV7OteyNIzKqV0gRPTvllgqr+R
	k2/+BmVo6x4B5YGFvS+FFj2Bm+YCXVVEIT1xs/IcYPMGieQxDZbv+ZWWjMPnOSB0ZsOLYZUFmPg
	kaBrYaK6++n6p48RT+H8e/xnVGr425yQSxS1gC13Eex4ga2OEBE09MyzAA2yBc1Jia+XxeuADkx
	T52pFnjtOLgt+JEyfBO3X5CO7N/n0BlCYCFby
X-Received: by 2002:a05:6a20:729f:b0:35e:9b66:9376 with SMTP id adf61e73a8af0-369afa035a2mr16868848637.60.1765970067883;
        Wed, 17 Dec 2025 03:14:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNTg6hqlZ0XwSkU/jTBqv7XhJy48kIxUqoEf4FNR5dL6SPZ4X3PygMDvCWSHV8N1oFIjZy0g==
X-Received: by 2002:a05:6a20:729f:b0:35e:9b66:9376 with SMTP id adf61e73a8af0-369afa035a2mr16868816637.60.1765970067294;
        Wed, 17 Dec 2025 03:14:27 -0800 (PST)
Received: from [10.218.13.44] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f2563b116sm159655705ad.102.2025.12.17.03.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 03:14:26 -0800 (PST)
Message-ID: <d873edd1-69d4-4616-9737-1f08abf2b512@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 16:44:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Initial LE Channel Sounding
 support by defining required HCI command/event structures.
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, anubhavg@qti.qualcomm.com,
        mohamull@qti.qualcomm.com, hbandi@qti.qualcomm.com,
        Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251216113753.3969183-1-naga.akella@oss.qualcomm.com>
 <e94d7fca-36f8-4acd-bd84-06f2cc9c4246@molgen.mpg.de>
Content-Language: en-US
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
In-Reply-To: <e94d7fca-36f8-4acd-bd84-06f2cc9c4246@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VLnoOOGGpAh__yRtC7KfT_Vg5Qi5LLgh
X-Proofpoint-ORIG-GUID: VLnoOOGGpAh__yRtC7KfT_Vg5Qi5LLgh
X-Authority-Analysis: v=2.4 cv=f/RFxeyM c=1 sm=1 tr=0 ts=69429095 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=JNKhDGE5xemXC_OFFgEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA4OSBTYWx0ZWRfXygf/xDGvPm2z
 t/cOq/qntJztBonoZY44RjfDBnudeMLC0DFvBIEuiB2FOyr0TvOvEMnOz0K8Qujx1KAAWG1eh35
 NkbxBNHovX8tFAPEVKSPs3cSiOg8gp+QX24inaP1fi5dtr5wq4xuSbbO7cVEJSVfkzO4N/un15z
 r5x7+b0vg4cO89DzT+QPGL0n8NjjU7nUiNLHiawNrMKhsayA8KVlOlteP7MfwiAXxOvPEv29oaz
 ajCQVTlwzThpOqMlSjwK4cJJwnWhAe7S2QMiWgCA9bfZAcaOV0jXfLOpGo415rZIn1l7Op+kIvi
 sy1a9Hdq6/gplR8qRqIzk/NxfiD+PzBU8fUqpKJsZcAaToUpBwbsTXAoglnQQRghqqj5ng+T6zP
 FO4hM9Zf/MQmhLzBxmU5G05I4PD58Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170089

Hi Paul, Luiz,

Thank you for the comments, will address the comments in the next patchset.
We are currently testing on a setup which doesn't support BCS.

Thanks,
Bhavani

On 12/16/2025 10:26 PM, Paul Menzel wrote:
> Dear Naga,
> 
> 
> Thank you for your patch. Just a formally to please remove the dot/period at the end of the summary/title (subject) and also make it a statement by adding a verb in imperative mood.
> 
> 
> Am 16.12.25 um 12:37 schrieb Naga Bhavani Akella:
>> 1. Implementing the LE Event Mask to include events required for
>>     LE Channel Sounding.
> 
> I’d use imperative mood (also below):
> 
> Implement …
> 
>> 2. Enabling the Channel Sounding feature bit in the
>>     LE Host Supported Features command.
>> 3. Defining HCI command and event structures necessary for
>>     LE Channel Sounding functionality.
> 
> Is a test already possible?
> 
>> Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
>> ---
>>   include/net/bluetooth/hci.h      | 323 +++++++++++++++++++++++++++++++
>>   include/net/bluetooth/hci_core.h |   6 +
>>   net/bluetooth/hci_sync.c         |  15 ++
>>   3 files changed, 344 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index a27cd3626b87..33ec8ddd2119 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -654,6 +654,8 @@ enum {
>>   #define HCI_LE_ISO_BROADCASTER        0x40
>>   #define HCI_LE_ISO_SYNC_RECEIVER    0x80
>>   #define HCI_LE_LL_EXT_FEATURE        0x80
>> +#define HCI_LE_CHANNEL_SOUNDING        0x40
>> +#define HCI_LE_CHANNEL_SOUNDING_HOST    0x80
>>     /* Connection modes */
>>   #define HCI_CM_ACTIVE    0x0000
>> @@ -2269,6 +2271,204 @@ struct hci_cp_le_read_all_remote_features {
>>       __u8     pages;
>>   } __packed;
>>   +/* Channel Sounding Commands */
>> +#define HCI_OP_LE_CS_RD_LOCAL_SUPP_CAP    0x2089
>> +struct hci_rp_le_cs_rd_local_supp_cap {
>> +    __u8    status;
>> +    __u8    num_config_supported;
>> +    __le16    max_consecutive_procedures_supported;
>> +    __u8    num_antennas_supported;
>> +    __u8    max_antenna_paths_supported;
>> +    __u8    roles_supported;
>> +    __u8    modes_supported;
>> +    __u8    rtt_capability;
>> +    __u8    rtt_aa_only_n;
>> +    __u8    rtt_sounding_n;
>> +    __u8    rtt_random_payload_n;
>> +    __le16    nadm_sounding_capability;
>> +    __le16    nadm_random_capability;
>> +    __u8    cs_sync_phys_supported;
>> +    __le16    subfeatures_supported;
>> +    __le16    t_ip1_times_supported;
>> +    __le16    t_ip2_times_supported;
>> +    __le16    t_fcs_times_supported;
>> +    __le16    t_pm_times_supported;
>> +    __u8    t_sw_time_supported;
>> +    __u8    tx_snr_capability;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_RD_RMT_SUPP_CAP        0x208A
>> +struct hci_cp_le_cs_rd_local_supp_cap {
>> +    __le16    conn_hdl;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_WR_CACHED_RMT_SUPP_CAP    0x208B
>> +struct hci_cp_le_cs_wr_cached_rmt_supp_cap {
>> +    __le16    conn_hdl;
>> +    __u8    num_config_supported;
>> +    __le16    max_consecutive_procedures_supported;
>> +    __u8    num_antennas_supported;
>> +    __u8    max_antenna_paths_supported;
>> +    __u8    roles_supported;
>> +    __u8    modes_supported;
>> +    __u8    rtt_capability;
>> +    __u8    rtt_aa_only_n;
>> +    __u8    rtt_sounding_n;
>> +    __u8    rtt_random_payload_n;
>> +    __le16    nadm_sounding_capability;
>> +    __le16    nadm_random_capability;
>> +    __u8    cs_sync_phys_supported;
>> +    __le16    subfeatures_supported;
>> +    __le16    t_ip1_times_supported;
>> +    __le16    t_ip2_times_supported;
>> +    __le16    t_fcs_times_supported;
>> +    __le16    t_pm_times_supported;
>> +    __u8    t_sw_time_supported;
>> +    __u8    tx_snr_capability;
>> +} __packed;
>> +
>> +struct hci_rp_le_cs_wr_cached_rmt_supp_cap {
>> +    __u8    status;
>> +    __le16    conn_hdl;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_SEC_ENABLE            0x208C
>> +struct hci_cp_le_cs_sec_enable {
>> +    __le16    conn_hdl;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_SET_DEFAULT_SETTINGS    0x208D
>> +struct hci_cp_le_cs_set_default_settings {
>> +    __le16  conn_hdl;
>> +    __u8    role_enable;
>> +    __u8    cs_sync_ant_sel;
>> +    __s8    max_tx_power;
>> +} __packed;
>> +
>> +struct hci_rp_le_cs_set_default_settings {
>> +    __u8    status;
>> +    __le16  conn_hdl;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_RD_RMT_FAE_TABLE        0x208E
>> +struct hci_cp_le_cs_rd_rmt_fae_table {
>> +    __le16    conn_hdl;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_WR_CACHED_RMT_FAE_TABLE    0x208F
>> +struct hci_cp_le_cs_wr_rmt_cached_fae_table {
>> +    __le16    conn_hdl;
>> +    __u8    remote_fae_table[72];
>> +} __packed;
>> +
>> +struct hci_rp_le_cs_wr_rmt_cached_fae_table {
>> +    __u8    status;
>> +    __le16  conn_hdl;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_CREATE_CONFIG        0x2090
>> +struct hci_cp_le_cs_create_config {
>> +    __le16    conn_hdl;
>> +    __u8    config_id;
>> +    __u8    create_context;
>> +    __u8    main_mode_type;
>> +    __u8    sub_mode_type;
>> +    __u8    min_main_mode_steps;
>> +    __u8    max_main_mode_steps;
>> +    __u8    main_mode_repetition;
>> +    __u8    mode_0_steps;
>> +    __u8    role;
>> +    __u8    rtt_type;
>> +    __u8    cs_sync_phy;
>> +    __u8    channel_map[10];
>> +    __u8    channel_map_repetition;
>> +    __u8    channel_selection_type;
>> +    __u8    ch3c_shape;
>> +    __u8    ch3c_jump;
>> +    __u8    reserved;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_REMOVE_CONFIG        0x2091
>> +struct hci_cp_le_cs_remove_config {
>> +    __le16    conn_hdl;
>> +    __u8    config_id;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_SET_CH_CLASSIFICATION    0x2092
>> +struct hci_cp_le_cs_set_ch_classification {
>> +    __u8    ch_classification[10];
>> +} __packed;
>> +
>> +struct hci_rp_le_cs_set_ch_classification {
>> +    __u8    status;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_SET_PROC_PARAM        0x2093
>> +struct hci_cp_le_cs_set_proc_param {
>> +    __le16  conn_hdl;
>> +    __u8    config_id;
>> +    __le16    max_procedure_len;
>> +    __le16    min_procedure_interval;
>> +    __le16    max_procedure_interval;
>> +    __le16    max_procedure_count;
>> +    __u8    min_subevent_len[3];
>> +    __u8    max_subevent_len[3];
>> +    __u8    tone_antenna_config_selection;
>> +    __u8    phy;
>> +    __u8    tx_power_delta;
>> +    __u8    preferred_peer_antenna;
>> +    __u8    snr_control_initiator;
>> +    __u8    snr_control_reflector;
>> +} __packed;
>> +
>> +struct hci_rp_le_cs_set_proc_param {
>> +    __u8    status;
>> +    __le16  conn_hdl;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_SET_PROC_ENABLE        0x2094
>> +struct hci_cp_le_cs_set_proc_param {
>> +    __le16  conn_hdl;
>> +    __u8    config_id;
>> +    __u8    enable;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_TEST            0x2095
>> +struct hci_cp_le_cs_test {
>> +    __u8    main_mode_type;
>> +    __u8    sub_mode_type;
>> +    __u8    main_mode_repetition;
>> +    __u8    mode_0_steps;
>> +    __u8    role;
>> +    __u8    rtt_type;
>> +    __u8    cs_sync_phy;
>> +    __u8    cs_sync_antenna_selection;
>> +    __u8    subevent_len[3];
>> +    __le16    subevent_interval;
>> +    __u8    max_num_subevents;
>> +    __u8    transmit_power_level;
>> +    __u8    t_ip1_time;
>> +    __u8    t_ip2_time;
>> +    __u8    t_fcs_time;
>> +    __u8    t_pm_time;
>> +    __u8    t_sw_time;
>> +    __u8    tone_antenna_config_selection;
>> +    __u8    reserved;
>> +    __u8    snr_control_initiator;
>> +    __u8    snr_control_reflector;
>> +    __le16    drbg_nonce;
>> +    __u8    channel_map_repetition;
>> +    __le16    override_config;
>> +    __u8    override_parameters_length;
>> +    __u8    override_parameters_data[];
>> +} __packed;
>> +
>> +struct hci_rp_le_cs_test {
>> +    __u8    status;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CS_TEST_END            0x2096
>> +
>>   /* ---- HCI Events ---- */
>>   struct hci_ev_status {
>>       __u8    status;
>> @@ -2960,6 +3160,129 @@ struct hci_evt_le_read_all_remote_features_complete {
>>       __u8    features[248];
>>   } __packed;
>>   +/* Channel Sounding Events */
>> +#define HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE    0x2C
>> +struct hci_evt_le_cs_read_rmt_supp_cap_complete {
>> +    __u8    status;
>> +    __le16    conn_hdl;
>> +    __u8    num_configs_supp;
>> +    __le16    max_consec_proc_supp;
>> +    __u8    num_ant_supp;
>> +    __u8    max_ant_path_supp;
>> +    __u8    roles_supp;
>> +    __u8    modes_supp;
>> +    __u8    rtt_cap;
>> +    __u8    rtt_aa_only_n;
>> +    __u8    rtt_sounding_n;
>> +    __u8    rtt_rand_payload_n;
>> +    __le16    nadm_sounding_cap;
>> +    __le16    nadm_rand_cap;
>> +    __u8    cs_sync_phys_supp;
>> +    __le16    sub_feat_supp;
>> +    __le16    t_ip1_times_supp;
>> +    __le16    t_ip2_times_supp;
>> +    __le16    t_fcs_times_supp;
>> +    __le16    t_pm_times_supp;
>> +    __u8    t_sw_times_supp;
>> +    __u8    tx_snr_cap;
>> +} __packed;
>> +
>> +#define HCI_EVT_LE_CS_READ_RMT_FAE_TABLE_COMPLETE    0x2D
>> +struct hci_evt_le_cs_read_rmt_fae_table_complete {
>> +    __u8    status;
>> +    __le16    conn_hdl;
>> +    __u8    remote_fae_table[72];
>> +} __packed;
>> +
>> +#define HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE        0x2E
>> +struct hci_evt_le_cs_security_enable_complete {
>> +    __u8    status;
>> +    __le16    conn_hdl;
>> +} __packed;
>> +
>> +#define HCI_EVT_LE_CS_CONFIG_COMPLETE            0x2F
>> +struct hci_evt_le_cs_config_complete {
>> +    __u8    status;
>> +    __le16    conn_hdl;
>> +    __u8    config_id;
>> +    __u8    action;
>> +    __u8    main_mode_type;
>> +    __u8    sub_mode_type;
>> +    __u8    min_main_mode_steps;
>> +    __u8    max_main_mode_steps;
>> +    __u8    main_mode_rep;
>> +    __u8    mode_0_steps;
>> +    __u8    role;
>> +    __u8    rtt_type;
>> +    __u8    cs_sync_phy;
>> +    __u8    channel_map[10];
>> +    __u8    channel_map_rep;
>> +    __u8    channel_sel_type;
>> +    __u8    ch3c_shape;
>> +    __u8    ch3c_jump;
>> +    __u8    reserved;
>> +    __u8    t_ip1_time;
>> +    __u8    t_ip2_time;
>> +    __u8    t_fcs_time;
>> +    __u8    t_pm_time;
>> +} __packed;
>> +
>> +#define HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE        0x30
>> +struct hci_evt_le_cs_procedure_enable_complete {
>> +    __u8    status;
>> +    __le16    conn_hdl;
>> +    __u8    config_id;
>> +    __u8    state;
>> +    __u8    tone_ant_config_sel;
>> +    __s8    sel_tx_pwr;
>> +    __u8    sub_evt_len[3];
>> +    __u8    sub_evts_per_evt;
>> +    __le16    sub_evt_intrvl;
>> +    __le16    evt_intrvl;
>> +    __le16    proc_intrvl;
>> +    __le16    proc_counter;
>> +    __le16    max_proc_len;
>> +} __packed;
>> +
>> +#define HCI_EVT_LE_CS_SUBEVENT_RESULT            0x31
>> +struct hci_evt_le_cs_subevent_result {
>> +    __le16    conn_hdl;
>> +    __u8    config_id;
>> +    __le16    start_acl_conn_evt_counter;
>> +    __le16    proc_counter;
>> +    __le16    freq_comp;
>> +    __u8    ref_pwr_lvl;
>> +    __u8    proc_done_status;
>> +    __u8    subevt_done_status;
>> +    __u8    abort_reason;
>> +    __u8    num_ant_paths;
>> +    __u8    num_steps_reported;
>> +    __u8    step_mode[0]; /* depends on num_steps_reported */
>> +    __u8    step_channel[0]; /* depends on num_steps_reported */
>> +    __u8    step_data_length[0]; /* depends on num_steps_reported */
>> +    __u8    step_data[0]; /* depends on num_steps_reported */
>> +} __packed;
>> +
>> +#define HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE        0x32
>> +struct hci_evt_le_cs_subevent_result_continue {
>> +    __le16    conn_hdl;
>> +    __u8    config_id;
>> +    __u8    proc_done_status;
>> +    __u8    subevt_done_status;
>> +    __u8    abort_reason;
>> +    __u8    num_ant_paths;
>> +    __u8    num_steps_reported;
>> +    __u8    step_mode[0]; /* depends on num_steps_reported */
>> +    __u8    step_channel[0]; /* depends on num_steps_reported */
>> +    __u8    step_data_length[0]; /* depends on num_steps_reported */
>> +    __u8    step_data[0]; /* depends on num_steps_reported */
>> +} __packed;
>> +
>> +#define HCI_EVT_LE_CS_TEST_END_COMPLETE            0x33
>> +struct hci_evt_le_cs_test_end_complete {
>> +    __u8    status;
>> +} __packed;
>> +
>>   #define HCI_EV_VENDOR            0xff
>>     /* Internal events generated by Bluetooth stack */
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 4263e71a23ef..0152299a00b9 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -2071,6 +2071,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>>   #define ll_ext_feature_capable(dev) \
>>       ((dev)->le_features[7] & HCI_LE_LL_EXT_FEATURE)
>>   +/* Channel sounding support */
>> +#define chann_sounding_capable(dev) \
>> +    (((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING))
>> +#define chann_sounding_host_capable(dev) \
>> +    (((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING_HOST))
>> +
>>   #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
>>       (!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
>>   diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index a9f5b1a68356..67b2c55ec043 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -4427,6 +4427,17 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
>>           events[4] |= 0x02;    /* LE BIG Info Advertising Report */
>>       }
>>   +    if (chann_sounding_capable(hdev)) {
>> +        /* Channel Sounding events */
>> +        events[5] |= 0x08;    /* LE CS Read Remote Supported Cap Complete event */
>> +        events[5] |= 0x10;    /* LE CS Read Remote FAE Table Complete event */
>> +        events[5] |= 0x20;    /* LE CS Security Enable Complete event */
>> +        events[5] |= 0x40;    /* LE CS Config Complete event */
>> +        events[5] |= 0x80;    /* LE CS Procedure Enable Complete event */
>> +        events[6] |= 0x01;    /* LE CS Subevent Result event */
>> +        events[6] |= 0x02;    /* LE CS Subevent Result Continue event */
>> +        events[6] |= 0x04;    /* LE CS Test End Complete event */
>> +    }
>>       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
>>                        sizeof(events), events, HCI_CMD_TIMEOUT);
>>   }
>> @@ -4572,6 +4583,10 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
>>       cp.bit_number = 32;
>>       cp.bit_value = iso_enabled(hdev) ? 0x01 : 0x00;
>>   +    /* Channel Sounding (Host Support) */
>> +    cp.bit_number = 47;
>> +    cp.bit_value = chann_sounding_capable(hdev) ? 0x01 : 0x00;
>> +
>>       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
>>                        sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>>   }
> 
> 
> Kind regards,
> 
> Paul


