Return-Path: <netdev+bounces-219074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB7CB3F9F3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C71E1885E3F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB362EA46E;
	Tue,  2 Sep 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqJ89l/X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011562E8E03
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804494; cv=none; b=eHexmIAuEEnJVub8mJQFD2ElC4f8vEZ5rYg2gZ3NAp6dG1IQygzt1UhGALjHiCC2eFIwt4b+TDYWW6KtfauA80hN+ZRys+8FTrVT/YbJgR7FEMoQPrnlhqrzHrDP+MfTSO2K5/KFx4GuNT3OjFV/YXgtXFe4ksE4pVK6dQum8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804494; c=relaxed/simple;
	bh=Sv5rjcMW0XRL3T4QTlzK6bGt+YKcn27Pk+A4Io6DRG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckyYcMWZT0qjJfEhXL7ohxKo265wQVclpaGjFnTOwmYx73Ki6bu/RW0MQtfmzN5GCMnATlQIIJ5TCVlEyleRyvI0MSotBVbKboPB2C7vpl8Su2Gj92URGJ7cBYQb0rKd3LnGr/qFd9kUHqZVLECfqpB6oyiNJcEicZac7Jxpkf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqJ89l/X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822TH59027558
	for <netdev@vger.kernel.org>; Tue, 2 Sep 2025 09:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JO1ghtzbf6msdOeC9Wq7UpFQnYphPOPa6N9e0whQQw4=; b=lqJ89l/XL7eohyXm
	B8/rx5P7wR+PqB9DzMZasnXgDSPmlEoK0i6/51pgt12C+LHKoT0bJF/KkQyXl9U5
	/j3cmOREMAt54FT0DhrgbglP+buY+m6sudUohFCofhElnTMcSRVAvRFXIVmEHoWh
	MVQVFJSCboTZr8znRg0t9C7Ey52df/8ukG8fFVbYGBts2SpLHlxo9yMaT5ufsWsK
	gj9vNI3vMtbR0GZ/ExiSL2nmQ5bgBHeT/Ar25Y0+CQIvigpZuC2KmD5cCgMugjr6
	7QdNBXVkGEubRGSogx2YmIHaqTnk8m09pdDdlL6QtWXrEoXbfhxNe4mzDq2XJjvD
	sn72Nw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuy975-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 09:14:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7f7e24d88acso99226085a.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 02:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804491; x=1757409291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JO1ghtzbf6msdOeC9Wq7UpFQnYphPOPa6N9e0whQQw4=;
        b=eZxgaXs7QF9mCjFpLI80v8fQD8fTgtA+5ncDT2OSTUUsRC45rGXA6ZcR3buXbz9wGb
         CTXVx5aiz6n7m3PFQm/COrr2R3grS5+nxOOf/vWLQqXDhC3clgZFvTKkZ0ioX/gd4zfs
         CV15xhQh76IH4znKh96Irjs03fiW0x+Qa9YQhmMt8miVCO+aifKx8+E1hvCUUCK8FXbZ
         JORb26VHI9ZIAjuVzMriivI4pyP9YtAcSTwT3XECKMmNXlo3GdPAVM8rzXwA1LYhNKOs
         5o6ZF9g7nETc9nQkNiBX0HFn45LvRKHOQdX9FuFk1dZO42MX9MNqo0MvyaYdvKKeiX3m
         k/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWCu6V7W1tPhfNi4vZyJuIuaUf9EngARUGZqy5mwKyX1Tz4atlgeXiocxxGQVcqJmiph6/k14M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaWI6KTgd+IkaZAtYmWWXoyBSc6RUG8H4jpOxVUKF9jcgkC0nU
	kRGKoNsvkxlHmr/1ZRh7eJj7KNjO3qXmRrrAd/7BJTTvUmipd2Z7lbr08+9OmMvIXMnnAsXOtvu
	h4AH9ilWGZQhZyGCp+t8hy240LM1uYY5oSqbfFAGcKfH0NLW3f/7ipBtk2PE=
X-Gm-Gg: ASbGncvgRAcH5piNkxkzHghRa7HZ2DGkogKV+AInRC9kHmoKclEu/YdTJC+3GCqyDDx
	ojIzP574+J7i3VCL8QfDElna+noyu3NUOanXH/pV+GLe5MHPfgptFJrFGawZoOjcf58cYdNPogV
	ou77xgqLsATamaIvN04KbE0vPYA+iNGt/HGLLEvdSSnl6oseC7nLjIj30LCjKrPOXZcrAz5kcHk
	tElM6+/PCKMB7TtJeGp6ordL2Iqzuudktl9EzjkP9J4yMe7QYEa7HHNKRdxdl2HOAdlodzgGYTH
	2YgS2aKQ6A54AQK5BF9Gp/nIcleYslRYrHmKzCIRfRgi1IMvC26104rLQvdCJuS6DKbimNSxQdR
	26ONeZPigDeIbPLT9q7J5Og==
X-Received: by 2002:a05:6214:5083:b0:70d:dcc0:75e with SMTP id 6a1803df08f44-70fa1e3755cmr93720556d6.4.1756804490119;
        Tue, 02 Sep 2025 02:14:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdxjzG5x24toM7rERz1x8tefpoUw5nxnJ08BKoZmfBLD2lh1HYnUpQ1tPf3aK4LYj/wz/d7A==
X-Received: by 2002:a05:6214:5083:b0:70d:dcc0:75e with SMTP id 6a1803df08f44-70fa1e3755cmr93720336d6.4.1756804489632;
        Tue, 02 Sep 2025 02:14:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61ec8516621sm192683a12.26.2025.09.02.02.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:14:49 -0700 (PDT)
Message-ID: <16698a59-1a2f-4816-98fe-56b125be669b@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 11:14:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] bus: mhi: host: Update the Time sync logic to read 64
 bit register value
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        taniya.das@oss.qualcomm.com, imran.shaik@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
 <20250818-tsc_time_sync-v1-4-2747710693ba@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250818-tsc_time_sync-v1-4-2747710693ba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX6okCVR6ul2Vt
 gfZXu5TI0HSLgoj0iXZamFSmq50SJFYDmgEkc1wwtPUFMgu3zzT5+3hnNUQP+gSDKldIbHJ5Ad9
 rqxSN+3BTbGgJbjfdits5AIOKe6wtsoWzRpI4Xhsbymj7nHMciJ0fMvrxYjOpXTjDQdAowvdNRS
 2h7SW8z7c5UwcioJMrWk110gc8LiYpk61Za3x0Nd4ZJu82clK28kCqHV2DgJfJhE4bzqRHgpK80
 Qir2jOsxo4z4VCIc64igCXDnHFU6+RQrQ+m/n9ie9sgPXqU7KH5ljT/33KLHPiiwZLbO4CnK7j3
 kJr38rWOInqKbCJfpbZusf2x8fS7wk5n0eeUJdB9lfugpaXI370qquJT1kp5ENLsRzTP0gOl3Zh
 HNn9xZkG
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6b58b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YtfURPx0HkL0cCzLSeoA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 3ruS34STF0o7mQgqxEO-d_kwK3ow751R
X-Proofpoint-GUID: 3ruS34STF0o7mQgqxEO-d_kwK3ow751R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 8/18/25 8:55 AM, Krishna Chaitanya Chundru wrote:
> Instead of reading low and high of the mhi registers twice use 64 bit
> register value to avoid any time penality.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/bus/mhi/host/main.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index b7ceeb7261b708d46572d1f68dc277b6e1186b6e..f628198218ef9dc760bbfc3ec496603d1a45dfc1 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1719,6 +1719,7 @@ static int mhi_get_remote_time(struct mhi_controller *mhi_cntrl, struct mhi_time
>  			       struct mhi_timesync_info *time)
>  {
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	u64 val = U64_MAX;
>  	int ret, i;
>  
>  	if (!mhi_tsync && !mhi_tsync->time_reg) {
> @@ -1756,15 +1757,25 @@ static int mhi_get_remote_time(struct mhi_controller *mhi_cntrl, struct mhi_time
>  	 * transition to L0.
>  	 */
>  	for (i = 0; i < MHI_NUM_BACK_TO_BACK_READS; i++) {
> -		ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
> -				   TSC_TIMESYNC_TIME_LOW_OFFSET, &time->t_dev_lo);
> +		if (mhi_cntrl->read_reg64) {
> +			ret = mhi_read_reg64(mhi_cntrl, mhi_tsync->time_reg,
> +					     TSC_TIMESYNC_TIME_LOW_OFFSET, &val);

Since you're passing mhi_cntrl to the read_reg64 function anyway,
perhaps this could remove some verbosity:

int mhi_read_reg64(...) {
	u32 val_hi, val_lo;
	u64 val;

	if (mhi_cntrl->read_reg64) {
		...
	} else {
		...
		val = FIELD_PREP(GENMASK(63, 32), val_hi)) |
		      FIELD_PREP(GENMASK(31, 0), val_lo));
	}

	return val
}


Konrad

