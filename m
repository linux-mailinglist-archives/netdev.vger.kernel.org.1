Return-Path: <netdev+bounces-284444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJWyNcj++WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:29:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B740F4CF68C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 681F0301FF0D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B048032A;
	Tue,  5 May 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VElEevCX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IrrgRhKx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9A2DF6E9
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991235; cv=none; b=GsR1TIHs4QnM/lycQM0cEVcl/eDqyz1ccXsF73420lMKvDxi1NCWp0jE1Sr96WVSOEv/rf7h0Gh2meho2DYYicZoCJf4HPE+McFlByeCH2p3m/ProldAfetx7BvS125V8IdKCyCI+HDUbFbIbPmW7WuWVO0YrX1CqU+KNPUXU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991235; c=relaxed/simple;
	bh=g+7IKxhiX7ztjndPO88YYZeyrSmovrRfOEc4pWd9eqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hljda6us7OSBhOl6/RpmYrjSI3shw/W9XdPkCDhiwRwlbhkbw9u/x0jLwAyR3fCWavOLa3bBldZtelLKK3kGZeQI8zaSAOiFnhZ7hyRPWjxewv6/b7LBSe9LBh4KBU4Uoew0TZzVJjZ5ltMedaeoEFH48DhKAAcBHrNwENt598Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VElEevCX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IrrgRhKx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EKtm2152028
	for <netdev@vger.kernel.org>; Tue, 5 May 2026 14:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pySiRqtx4zsZPi7B448XCfGRj+cLU/DeaDKDCajYXho=; b=VElEevCXAp/4eN7D
	j1foutEYx3Vr8neaXKIuICKqkE91uo573myvYqdDi3F5IXBbLooVoYNRod044YSw
	lR5mKzu4rIzdWRx2d/JbjvPxo63qQzGipzt1YBAOZDb5CwgrEeUBk9SQBK7yl7Op
	RnlGVj6RDVf2ezLny5rvOLp51ciXeHa568S8WVA1PeQpTaKKwley3XRb2f4jQskS
	Hmhv3KZWzdQeiQy5aE63//4swak+N6C1OmAAB5qmJA/QhPhJGZUGiWR296GpH8oC
	jGb+vyiCVHK5mJH+jvYSckZJgpYqawQ3A0oPr2XYkR5r+kxenrr5UZyU9vAXrI3h
	JzsaVQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj8080uk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 05 May 2026 14:27:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2f1383b7439so1924990eec.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777991233; x=1778596033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pySiRqtx4zsZPi7B448XCfGRj+cLU/DeaDKDCajYXho=;
        b=IrrgRhKxgJnx+fezZ1NeAlnQ6l4RiG2sFifsXMKlGHRf4C6wkOv8va1EnXq327cXkR
         0Nz/0bAcszpvtAoQaME6+f9ccs0W9h77C9SOyWIdiDwdolIIPKs2Rz3MlOtjdEmVHYXQ
         vqhckAwD/GZAUzvWI7Bk/UrDt1ptH2uFyuidpXph8o7A+fvqhcqhw1U/g9s8I8MEgyGQ
         zrwCRQYywin8U59zr2CSzF8o6OdALVBprz59rwhnjtWyfwdA0j59/N9/2jgHH9lS4r6J
         V30395+PH34urCGdOloCSoqrls0f+dqZH5l6RofWK0mSGpz+qrz+uDkg9xEL0y2g7UO0
         NjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777991233; x=1778596033;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pySiRqtx4zsZPi7B448XCfGRj+cLU/DeaDKDCajYXho=;
        b=geSq9hOMyyu15AUEwSV5MCIaqlyinFJqZgAdEa/YsZe1tJdxvgYI0sbwlWCucIZRkm
         pgeufLwJCoTThmPr3TIGDCuEORPDMkXvJk54a82Gfg2mecXUlcNs7oI5kEVBUvjSeS6N
         laP3/MmyTR1NcQ8Tyzp4aRiYLja7G69QN5tHQhf5v4VYJi5+TfHgU2ZTze6DVYbJDkAC
         r1Inep87W1J53Kip15T14ajWNOweYM/S5R3FGYO4IJBGvvlvqD2LbfOCAQjq2rhRbbK6
         3lw8s0B/5NvlHxpWVhSHkMF71OrlWhzv33sFuu7CT01DvPU5N4HozqpDP6l3/dNc5ul3
         8QIw==
X-Forwarded-Encrypted: i=1; AFNElJ8GxQWuP/3+bQ3lYE7Bbd52P2sNN7buSl1gYiS3jujB2B9ZGHmewHHB7S85GJ7Tr4h7USaljHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGd0HBNwq7CuyMDBsNZn+cPnPF1IpJdI5oxnvMjcLxfeWcwD5b
	tbc9GTNqiUB4+uC5fuMNG0G1vngrGYMJ46kOv3kOmy3vA6pgLSN2u2lVu/lG4FRSnxyA5pzBvDg
	Qaes4LLyhqzhVwMTk4BgwQkBBGvHtcfQ6HhNCjMPIbD7aYixkN1AKntiUr64=
X-Gm-Gg: AeBDieubFiXS0d+tYGAxWN/SQmac+p/cJQVbm3G5VIzV0IlgWUHgAHS4vKWU6WyjbHO
	xj7s/+/IBX2OPEz1SE8tCeVUkqz0Pj3jqQceQQXqDaq3fbbjqwEqLESF0xP6oWoxH7vdx4kjYlo
	qO7+s1oDQsoyFFYInhv3yMPI3DbaoTsVh5X4wS3OyG/gkIMzBE34xwhdRiCKqFZRks1WyWd25XZ
	9ALt5VNn+Ec8XxbCbTVmiNnCNdHi6g1xfyk+NjCeaYdBWJuqKBCATnSEnGC3PTtqT5lhUSZ+4Lu
	sKkjL/xlJh0Y18XXamQDGgwteeX6RLSCnYtjY/rggiuO1RDSypvYhh0ODd0tpZW8ZZytLeHMSfT
	Ho7LR7lSUytEvNzsfsRnEpTi/A4SeZCtkde8aV+khI9CFxEXA8eu8KlooMvNEwrDdUUMNRlSIWV
	sOjaujqCYbLD0GAlAj
X-Received: by 2002:a05:701b:2507:b0:12d:de3e:86b2 with SMTP id a92af1059eb24-130a9ffb6e3mr1020228c88.21.1777991233083;
        Tue, 05 May 2026 07:27:13 -0700 (PDT)
X-Received: by 2002:a05:701b:2507:b0:12d:de3e:86b2 with SMTP id a92af1059eb24-130a9ffb6e3mr1020185c88.21.1777991232530;
        Tue, 05 May 2026 07:27:12 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84252c0sm23637548c88.10.2026.05.05.07.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 07:27:11 -0700 (PDT)
Message-ID: <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
Date: Tue, 5 May 2026 07:27:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
 <20260504130603.1474043-15-sumit.garg@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260504130603.1474043-15-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XvnK/1F9 c=1 sm=1 tr=0 ts=69f9fe41 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=_vM1m9lfSBLZ1nnPSXUA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: qEglhulpuUiaefQTKHsnO2-DPYI98cCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEzOCBTYWx0ZWRfX23WPe0j72vJj
 ALBGYEqoYu5oLv4lNMXjbjsByX0FQ/WwwPeoOJZqIhvD3C8ufNgc7rcdFrnpZl/LhyOHBLQhbJ2
 3qm4ppUZr/hHcYFl4ksnURRXjVAym0mc7ZRp+q0MiispsnWTs/53drwTrwZOOTRtXptXR1fTtDj
 zzWzC6S91YHNHlpYBBIquysM27DwI6ZExMk/Txba6tdgWtb45m3PrIoPdG6cP0tcuq9PA5REuuk
 Xf9uJOJT5Ty5HJO+FWDzYGw6DQQ48Hzzc6z69fLa8PTlG0JrL/rCz8aw4lz+egN1WF00qK1mPoH
 ZXVhw+4MutK/2tJtwCyMEOAde/0XSHE8zXQyltQDICS1bbiYx4v5S5GXPyWALpo6DQUjEFtnXko
 w3GCmDZaht6eF8cjV2EWIv5BGdPX/BvJdxukMOuYxn5Z9KVJTPYmVxE0Cpru0cGK+ZTYGwXIfHy
 PKiTiU0nXt0zOBPdqzA==
X-Proofpoint-GUID: qEglhulpuUiaefQTKHsnO2-DPYI98cCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050138
X-Rspamd-Queue-Id: B740F4CF68C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-284444-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/4/2026 6:06 AM, Sumit Garg wrote:
> @@ -485,9 +485,9 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>  			 ATH12K_AHB_UPD_SWID;
>  		/* Release the firmware */
> -		ret = qcom_scm_pas_shutdown(pasid);
> +		ret = qcom_pas_shutdown(pasid);
>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
>  				   ab_ahb->userpd_id);

at some point the "ret" param was dropped, and this now generates build warnings

>  	}
>  }


