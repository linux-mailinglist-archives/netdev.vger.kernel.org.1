Return-Path: <netdev+bounces-294261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G9pZMj/vHmq/ZQAAu9opvQ
	(envelope-from <netdev+bounces-294261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:57:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2C62F84A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="BHY+9/iE";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="H3Br/Id7";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294261-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294261-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8C4F31962C6
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958F3F20FF;
	Tue,  2 Jun 2026 14:44:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752883F0752
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 14:44:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411486; cv=none; b=XFNrtjtdM62F/mEinPTBrltC88zhKwBQtBLR0F3fFb1+OOltX6shsy9Xhb0BFZSZN824ZQIh1Wull+xSBZ/WZJciLhrcH+x/wlnS3LvkRoUMKiiclVUJe9PTauJliWxgYWj3loDxa4dC6fPuk4QrQyb28Eva4Di3EnMX+EmRqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411486; c=relaxed/simple;
	bh=JGSh5lAZ01h4V6/aN5YEeVciZCInCwqxQ6QqUvPGo90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiAxSmjzfeyD9OBCCoFDFq8eTk67c5ttMBM0162PHFrr+ile8VX6/k6lh92XlvxhthJLRlQ62zcklVDbxxgwM6QAGtDA2pwCCsqSCxT+Kl36zjtSoAqF/XJX3jdwziJwaLdGUlkpGLpDWMt3zyuxEQYirMOSmPStouWP4LWeUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BHY+9/iE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H3Br/Id7; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6529Uaa63355448
	for <netdev@vger.kernel.org>; Tue, 2 Jun 2026 14:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=g1qut49VqY6kixKrk363RsT3
	75KtaT3Dj3vgJwsvmMA=; b=BHY+9/iEQsfwnfFkozleq2w3xaPvI9jJpUfv9NRD
	9vIuRgUkEvPLCPdiWlD0M4NVxPar7XJqBHX4V5nxT8LBDbkSj9a7EdiFSxfibu7V
	btJRt8ioDdDgKZOLU0OI7HpcS/JQatOecRMeGvWtK1KsvB+fE2hPsb391s4Toy5I
	Yea+abZIfmOPW79A3oHkW+Sm1/g7zGEdL2BHAvgZBj/1otg1Aey735G/FaYIojVB
	xuH+jYHnuo3x3bmzFL2b7vU43vjZUpPmrjyj18jiDqZlAyT6hokevSB0pCv5sEUp
	UUbz0NIZ0Wgb1ZAevQh2KqNKDCXgzu+9TsDjpXfBbuZY1A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehvkx95kd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 14:44:44 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfe512e871so1257695137.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780411484; x=1781016284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1qut49VqY6kixKrk363RsT375KtaT3Dj3vgJwsvmMA=;
        b=H3Br/Id7H4q/WFdNqFVVAorPjfN6UEJ4r4YMHg0Gx4TzIR/6OaXh5HlzR3H3XW5Jkw
         Ya7TUhMaGQxRtzBAB/odYY02eHuVew1SwaQzQPlpFDb89fOIE1eRtDXdc5tCgAN1TRp8
         0/AoGwMzt9yqElQ/B6QDWUVdQajBLw74TCAj0KWhL1sp1N6AQQtX6RpM9461EL9W3xE3
         xqgxirZTPYQMxH7sKI+BGwX+t8m5dmZKOZ6jG14zK0rzq3Xl6vO2kGToWXRPSJ17+my9
         l4wcQkTKEvP3k9IEje3sQARCilLHAc5QORGfNbUV3ApLHWEDWsL0GMKBmB8dt8Jfbbjc
         Qciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780411484; x=1781016284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1qut49VqY6kixKrk363RsT375KtaT3Dj3vgJwsvmMA=;
        b=VbLDyG+BX+kOIXOpbPTe6FGgZJCLu2zLFU2Asl7rGzKDmPCVn8wl7DcYv/ZoqmsBHj
         mjnOZQ/KO7x8ia1OftHcR8ZwhwbqRGweUMrvtACT08aIFD0g8ySTtRrIRaZTaRF9qhM+
         zm1ackUYKMMpwHZubnpV1xT4vLK8aO2LKy5BH3CRumIbd+PqXIVHJsWaYFMvXHNJZ7nG
         3FLGWZ2hOfgi5SSmf9JlnFghZvtKL8RkJBBSG+eGhLxwsY7Dx0AJp5ZSheabAO/cpptS
         hUfOOOpCYHsTvQEIWMiWXwzhJl/KnrfI4bD/mrqlaEYDm8rnzFqACcPTLK3N2ET+xlbr
         d4sg==
X-Forwarded-Encrypted: i=1; AFNElJ+Eaz3lFzg04EWMEC1EhAmfa5qRrZ/lw/NOWm8dmVDQn7VIJzd3OeovXbOd0E6cEknfyJIWAA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMiXRLukA8PLG1C8HTfO1SxstWxjaw2gzwcBA39utClxc4pGuR
	5YrpGdqq4zjT+OQByGlNsgQvOvdItXkPoapIzFFmTe2HzXSZ5E96gqCacHFwS7/7YH692nl4xR/
	VuIbe6WnNvGTSpUIdQpSMfmZpGw9KpbEiHUG2ClaJCW2r7tQRrmWXUL0GZKo=
X-Gm-Gg: Acq92OElrr9841dVSizCWTbDAkA07L9tpr0LR/JYg8z+miVXojptpKY40LAP7DTwJPN
	4Aekx8VB+nALLc9AegwqUzuWfjYu7jROrmBQAvOepbWmbAfxHAC/BJgoV2DmI56yvHVpBv2Lfg8
	PjVa+WDd9F6yU2hdM5KbIcd+B5NXC8tzNf5y3KrF+HkQueP32/c5tC6NO8Spzz5x9rY2JPmx3fC
	qQfJoIuburuu8YjsKLljsiBoAEm8oGwJ2wes8pnyh8/ikoVmJwUHd6ep3/+MlWoDZ3yfxsA5zXj
	+Sd43CUwpKABWg3lIynWy9I08P6eGOpLAW6KDPXKodCsGJyDYoW33zZYl5AG9mC8zUdTNWvbfZY
	Bp0c0Mu6jgjTBXxmPUWNDSYunDcDnMff4B+kdEl8kw4DXKi4jGZgsoENgXfnaVdqiWQI=
X-Received: by 2002:a05:6102:3753:b0:604:ec90:ba14 with SMTP id ada2fe7eead31-6ea1ff9867fmr51550137.11.1780411483806;
        Tue, 02 Jun 2026 07:44:43 -0700 (PDT)
X-Received: by 2002:a05:6102:3753:b0:604:ec90:ba14 with SMTP id ada2fe7eead31-6ea1ff9867fmr51511137.11.1780411483296;
        Tue, 02 Jun 2026 07:44:43 -0700 (PDT)
Received: from QCOM-LDTZRie9bq.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e03709sm1166066b.30.2026.06.02.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:44:42 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:44:40 +0200
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        thomas.weissschuh@linutronix.de,
        Arthur Kiyanovski <akiyano@amazon.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
        linux-wireless@vger.kernel.org, linux-sound@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [patch V2 16/25] virtio_rtc: Use provided clock ID for history
 snapshot
Message-ID: <aupnwe2y24oxejpkjnlbzlmdiuuzlbqlahofgzipxwsnoir4jd@cwgplvoe46ok>
References: <20260529193435.921555544@kernel.org>
 <20260529195557.744271454@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529195557.744271454@kernel.org>
X-Proofpoint-ORIG-GUID: IBoIzLdqmSgu5-1N7SDpStU2E0kSbpnC
X-Authority-Analysis: v=2.4 cv=GYknWwXL c=1 sm=1 tr=0 ts=6a1eec5c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=pBOR-ozoAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=KhUNALZX6FJHKvLdx2oA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: IBoIzLdqmSgu5-1N7SDpStU2E0kSbpnC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE0MiBTYWx0ZWRfXxnN2DBDmC6Bi
 uZazGjz9cauZEphVaZOXSy6ZPR0qCLBsukg17Qiq2YwRVa4IoriTC0avYNzpfcvcveYxg/BfvRi
 CZQfO2scNHl8byNDrCfx+eR84nlugZb0TJ79Oo35fnup+5cYvZpq2STis+ZIfpgbaF1bjNm2CAa
 XehHo5ZeXeEm8FbWZ7LhkSOQXvGr3vrjpCGJvq5VEQum2VD7C04oJbxIxCfMeoptaInqpwq/Qml
 cWvEYeR4hJ+tpqavYCp2DIMFyeS2BbzUJZiISQq08wjxmfUeWZL+MNr4cdipREcJFAEJG7v8QeR
 eIYp9QYZwqMd/3PJP/SdMh/BbAwO2xxEAnnmVtI3uXsIpf3uclhB5ly/0vIV48t7Squ+3S95jlS
 Zq1qAsnv70nYZ1VRftsNb+PKdViXefDWVRz0RHRPwKWg43rEKx1aL6fEnlu7J41ZwO53jLAv1xL
 MKx1a7lUK0hGldQG+Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020142
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294261-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:mlichvar@redhat.com,m:jstultz@google.com,m:sboyd@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:thomas.weissschuh@linutronix.de,m:akiyano@amazon.com,m:giometti@enneenne.com,m:vdonnefort@google.com,m:maz@kernel.org,m:oliver.upton@linux.dev,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:tiwai@suse.com,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:saeedm@nvidia.com,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-sound@vger.kernel.org,m:dwmw@amazon.co.uk,m:vadim.fedorenko@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[peter.hilber@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,amazon.co.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:from_smtp,amazon.co.uk:email,cwgplvoe46ok:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.hilber@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BB2C62F84A

On Fri, May 29, 2026 at 10:00:52PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@kernel.org>
> 
> The PTP core indicates in system_device_crosststamp::clock_id the clock ID
> for which the system time stamp should be taken. That allows to utilize
> hardware timestamps with e.g. AUX clocks.
> 
> Use ktime_get_snapshot_id() and hand the provided clock ID in.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Acked-by: Peter Hilber <peter.hilber@oss.qualcomm.com>

> ---
>  drivers/virtio/virtio_rtc_ptp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> --- a/drivers/virtio/virtio_rtc_ptp.c
> +++ b/drivers/virtio/virtio_rtc_ptp.c
> @@ -139,7 +139,7 @@ static int viortc_ptp_getcrosststamp(str
>  	if (ret)
>  		return ret;
>  
> -	ktime_get_snapshot(&history_begin);
> +	ktime_get_snapshot_id(xtstamp->clock_id, &history_begin);
>  	if (history_begin.cs_id != cs_id)
>  		return -EOPNOTSUPP;
>  
> 

