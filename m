Return-Path: <netdev+bounces-250344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C60D29489
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7390B3004EFC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F1D31A7F7;
	Thu, 15 Jan 2026 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bPn2MLfO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g99dGUcy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4A30B507
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520349; cv=none; b=PmZsxV3Sysi+DTWW/vluTUbVmVvhKRnPeVTaOxn6GaCtYRmcPMKjsDJfi9Ubh8n4xSGUR8yVcn1RGOXC61AY6p9xhShCrTxoYdjFBlQ2d7KmiLEtFguALNfNAE0xA1TR9nVdxTH7uo60ztYcafaLSjCVsb6MA3eJ+e1HIyiq8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520349; c=relaxed/simple;
	bh=diOCoI9VOsjOAu/507QXYCM7x9GdnxmatG52rgvVsME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5GJaQM2JU2eczPNHx9E8kpW2adRxMcsPR7AZmY12pLyvtjZqxc7D6Y2zbjlWbFOBvbINkQksY+C1LelDRml7oyUmVXDkWIIO7Na2jmSkMEldbvvzrrc5X4reUzIJvrBaVTqjY6V34694aGy0GNCi5hLcJ2twyhMH0Lbz/BKsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bPn2MLfO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g99dGUcy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMksW23892842
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lVjbzz/3UHEVM8eIBqM6zUUfmDnOkJGwAR300ilUdt4=; b=bPn2MLfO8ccKF5M8
	qvd2qjQQrp50ki2vtg/RzgT6tI/H5n79pMFFv5JgXXSr2msxraHJksMAOR7Cj694
	AvzN+HYRvu/4fgS0z67SUH1TWyHBzmxqp90u2ANowc4hBuvn9wzTWBnZlUNq2RRv
	RR4JnbPUV9ET4uK3tjcOCU2FWDq5W7/cFhwJP+KiXE7I+U34BMafWV5s3pbHD+fc
	2DAWk4nXjdjISloXd3Jj6r3oP0etj45TsZRKObtLMrh4brf6ycbo2wngG6/2pcNE
	lcpG4lgv79zwEXqj8c0JIVI3Rv8BCGQnLQrGmtQkBrtZBmVldVN8ML5ezT/KkD0+
	vxpR0w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9b0835q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:39:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2adc3990fecso1037610eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 15:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768520346; x=1769125146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVjbzz/3UHEVM8eIBqM6zUUfmDnOkJGwAR300ilUdt4=;
        b=g99dGUcyEbvnUhI8FOaqTJwRa4H/3mjAEi78aiePn02cpR6L6p6k2UnO2MXvT1XDXm
         quBHXpdY0TU09JnCQALx1bF6qYgBOurRi4Cp9tXiV3cfr/1SnaJ7ZWZMb+O1klj1YeZL
         U8Y7qsfS0jqKBfKBpiMews7va/DEgTkSLeP9yVJohQisoK7703FK4trOVzRlGE1odYnD
         sJAFn9b3n1D/dRtsMT1n+f6qTl/aAb2/ijqnnXqzA5AZ9MJW/u8753C+hA6+TZuZQ7yS
         JUpj92+zqm6uJpsbhEaSVfT7dZiG+86nDrQ+4izHEWtnHWhlC7LF7SJjeaEgD0Fk77d9
         xflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768520346; x=1769125146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVjbzz/3UHEVM8eIBqM6zUUfmDnOkJGwAR300ilUdt4=;
        b=eQr1rmH/8YAU0j1hWJVfMn/1kDSllml5Q4UcfIi8CbSPQ47Vt8EnSx6Rj/6P2EfOaC
         zLE0oYEavvSpmz0UCHnrAdAIpIg+hR6S8D/TlaAnJUWFbh3GMC70wl6G4LblzBJRWLOP
         T1b3rHUGlxd7uFS/4PpVPPBbIu3RtdLFBst98kGpU0vJQm4ZJtkIi+48r9aZMvOkRcXh
         vbBNXFbXMvkwO9jRKDok5W7vFiZ1L+cQ2CyzkuQPwtVFzIJF3ZPS1EICLAZmeMLjRkAt
         ykNp7TtN5ErnKElUzZjFvWhxU7en/Qk6uKeNGXd/jssovQJApqO8hKCDqvQd9lBVpV0W
         /JSA==
X-Forwarded-Encrypted: i=1; AJvYcCUj7vjzfslLRApt+Izym2CdzGuIMp5cypU17UvTsomXF8k8tFBoMFs9HqH9Aasd7RWr3+KWp3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb8fc4/OW2/bYEDCW9gsruXiiUsWx9F7z29rwrC9D3vQwqyK/u
	6uZoayx4cfE3mUgBHrBw/pbPmUn/CG8gSIhuq8ZeBX5qXBTjIFkQk3wcTyQeoKi3e2HmqaYzPcd
	UJM61D0iqpKM9aCSqMOpFmXOx662fyBSc/DhuW8WD+VrAo9iqj1vO+02yPas=
X-Gm-Gg: AY/fxX4uCmYCS3ZuXVsNYH1he3ntDukYkiyhnIyU0a8bqafVxgVqwoucpH0N989bKIt
	adW/vjoLaAJNq7rbfLFeVzHkz8hjWapwpI0O+XlHn7oE4A70FHpzCAZKQTjCYkXvSqZgHaFHapb
	0fyUO6j1l5jcZCLAezyNfX7+NzoJ5zmDC5KajDjUQgLTmmuZ7F83W0b6pJ5jNP6wQXr6U+Ki0b9
	gwaHAxbVTs6GSH0GgjTGAlhe9mlB2/ZYZz9dKIORT54ClgAwOzBDJ3VapD+TC/QJQk+Tra4E5Sh
	6UFjyJpJHV2EeWr6dkTcYcUsAZ3N6cB9cZl9o8x4ztgYjR0W+XziO0h5GqjGRDV0f582dmtYNrw
	wBa86+o1yjL1RjQWd0BKEO7/MowAWoPaCLykPaGiQbQcypzvaBkD+9B5tP8icCHEEElGFq9dy
X-Received: by 2002:a05:7300:5353:b0:2ab:f490:79f9 with SMTP id 5a478bee46e88-2b6b35a1060mr1489624eec.21.1768520345990;
        Thu, 15 Jan 2026 15:39:05 -0800 (PST)
X-Received: by 2002:a05:7300:5353:b0:2ab:f490:79f9 with SMTP id 5a478bee46e88-2b6b35a1060mr1489590eec.21.1768520345345;
        Thu, 15 Jan 2026 15:39:05 -0800 (PST)
Received: from [10.226.49.150] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3682540sm699712eec.34.2026.01.15.15.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 15:39:05 -0800 (PST)
Message-ID: <919c0b7e-83d7-45e8-ae96-d9fb7a10995c@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 16:39:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/ras: Introduce the DRM RAS infrastructure over
 generic netlink
To: Riana Tauro <riana.tauro@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, aravind.iddamsetty@linux.intel.com,
        anshuman.gupta@intel.com, joonas.lahtinen@linux.intel.com,
        lukas@wunner.de, simona.vetter@ffwll.ch, airlied@gmail.com,
        pratik.bari@intel.com, joshua.santosh.ranjan@intel.com,
        ashwin.kumar.kulkarni@intel.com, shubham.kumar@intel.com,
        Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org, Jeff Hugo <jeff.hugo@oss.qualcomm.com>
References: <20251205083934.3602030-6-riana.tauro@intel.com>
 <20251205083934.3602030-7-riana.tauro@intel.com> <aTiWNkGmwFsxY-iO@intel.com>
 <b986eb03-0887-4eb2-a7a7-50ef63e51096@oss.qualcomm.com>
 <aWFruAO06O93ADjU@intel.com> <19fd4d44-b7d6-4bc2-9255-3d5159ec1435@intel.com>
Content-Language: en-US
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
In-Reply-To: <19fd4d44-b7d6-4bc2-9255-3d5159ec1435@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2zk77u_E3ld90VMm-Q0VKwId0-uSYNAf
X-Proofpoint-ORIG-GUID: 2zk77u_E3ld90VMm-Q0VKwId0-uSYNAf
X-Authority-Analysis: v=2.4 cv=TcmbdBQh c=1 sm=1 tr=0 ts=69697a9a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WFVl3Mxyj1LltjsbROYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE4NyBTYWx0ZWRfX34ZemE6idGL6
 qZioL8qmVBjcgagIAKZSHznQMUamPpawJbIpsN/O4cW+TrS0N6X2+QbIzux8v9XXNydRnvq5Q4f
 CaXV13JZ+5n+QxEL22tKS7KukXTHUoIpHQ2Iy5t4I2xOpfyJc2XPDy3TCaWcVPgI5oAvhLxnCIW
 ZCm8/VNyP8PL7hzYsfcq1UZ2oMTywPHK16y/2TonT2LHaYsJxxwG6dam1op9QaFLTH/MswX7AmT
 sUjI6yRbHe0CQARtgCgKZeJr7x1nUj5S34sn2a+h9sWuc8koa9Oah3gF4+ir7hPovlxMu/7BW5x
 WWpAyoJA9+YfR54b0UNNgzNa3Qg0qcm23vaeuplti8Vz6viw5Xvem0Y2SI0gEY08/BDyEMKujHq
 bIqb1MJegQePDb7DpXIPW3Kv62wZCv/L4eUpA/KJ76P4KIxAQbcTDJgq8nMod/GXBveCoihYJa5
 b5KuHwMk3RMdl1RFq4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601150187



On 1/13/2026 1:20 AM, Riana Tauro wrote:
>>>>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/ 
>>>>> Documentation/netlink/specs/drm_ras.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..be0e379c5bc9
>>>>> --- /dev/null
>>>>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>>>>> @@ -0,0 +1,130 @@
>>>>> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR 
>>>>> BSD-3-Clause)
>>>>> +---
>>>>> +name: drm-ras
>>>>> +protocol: genetlink
>>>>> +uapi-header: drm/drm_ras.h
>>>>> +
>>>>> +doc: >-
>>>>> +  DRM RAS (Reliability, Availability, Serviceability) over Generic 
>>>>> Netlink.
>>>>> +  Provides a standardized mechanism for DRM drivers to register 
>>>>> "nodes"
>>>>> +  representing hardware/software components capable of reporting 
>>>>> error counters.
>>>>> +  Userspace tools can query the list of nodes or individual error 
>>>>> counters
>>>>> +  via the Generic Netlink interface.
>>>>> +
>>>>> +definitions:
>>>>> +  -
>>>>> +    type: enum
>>>>> +    name: node-type
>>>>> +    value-start: 1
>>>>> +    entries: [error-counter]
>>>>> +    doc: >-
>>>>> +         Type of the node. Currently, only error-counter nodes are
>>>>> +         supported, which expose reliability counters for a 
>>>>> hardware/software
>>>>> +         component.
>>>>> +
>>>>> +attribute-sets:
>>>>> +  -
>>>>> +    name: node-attrs
>>>>> +    attributes:
>>>>> +      -
>>>>> +        name: node-id
>>>>> +        type: u32
>>>>> +        doc: >-
>>>>> +             Unique identifier for the node.
>>>>> +             Assigned dynamically by the DRM RAS core upon 
>>>>> registration.
>>>>> +      -
>>>>> +        name: device-name
>>>>> +        type: string
>>>>> +        doc: >-
>>>>> +             Device name chosen by the driver at registration.
>>>>> +             Can be a PCI BDF, UUID, or module name if unique.
>>>>> +      -
>>>>> +        name: node-name
>>>>> +        type: string
>>>>> +        doc: >-
>>>>> +             Node name chosen by the driver at registration.
>>>>> +             Can be an IP block name, or any name that identifies the
>>>>> +             RAS node inside the device.
>>>>> +      -
>>>>> +        name: node-type
>>>>> +        type: u32
>>>>> +        doc: Type of this node, identifying its function.
>>>>> +        enum: node-type
>>>>> +  -
>>>>> +    name: error-counter-attrs
>>>>> +    attributes:
>>>>> +      -
>>>>> +        name: node-id
>>>>> +        type: u32
>>>>> +        doc:  Node ID targeted by this error counter operation.
>>>>> +      -
>>>>> +        name: error-id
>>>>> +        type: u32
>>>>> +        doc: Unique identifier for a specific error counter within 
>>>>> an node.
>>>>> +      -
>>>>> +        name: error-name
>>>>> +        type: string
>>>>> +        doc: Name of the error.
>>>>> +      -
>>>>> +        name: error-value
>>>>> +        type: u32
>>>>> +        doc: Current value of the requested error counter.
>>>>> +
>>>>> +operations:
>>>>> +  list:
>>>>> +    -
>>>>> +      name: list-nodes
>>>>> +      doc: >-
>>>>> +           Retrieve the full list of currently registered DRM RAS 
>>>>> nodes.
>>>>> +           Each node includes its dynamically assigned ID, name, 
>>>>> and type.
>>>>> +           **Important:** User space must call this operation 
>>>>> first to obtain
>>>>> +           the node IDs. These IDs are required for all subsequent
>>>>> +           operations on nodes, such as querying error counters.
>>>
>>> I am curious about security implications of this design.
>>
>> hmm... very good point you are raising here.
>>
>> This current design relies entirely in the CAP_NET_ADMIN.
>> No driver would have the flexibility to choose anything differently.
>> Please notice that the flag admin-perm is hardcoded in this yaml file.
>>
>>> If the complete
>>> list of RAS nodes is visible for any process on the system (and one 
>>> wants to
>>> avoid requiring CAP_NET_ADMIN), there should be some way to enforce
>>> permission checks when performing these operations if desired.
>>
>> Right now, there's no way that the driver would choose not avoid 
>> requiring
>> CAP_NET_ADMIN...
>>
>> Only way would be the admin to give the cap_net_admin to the tool with:
>>
>> $ sudo setcap cap_net_admin+ep /bin/drm_ras_tool
>>
>> but not ideal and not granular anyway...
>>
>>>
>>> For example, this might be implemented in the driver's definition of
>>> callback functions like query_error_counter; some drivers may want to 
>>> ensure
>>> that the process can in fact open the file descriptor corresponding 
>>> to the
>>> queried device before serving a netlink request. Is it enough for a 
>>> driver
>>> to simply return -EPERM in this case? Any driver that doesnt wish to 
>>> protect
>>> its RAS nodes need not implement checks in their callbacks.
>>
>> Fair enough. If we want to give the option to the drivers, then we need:
>>
>> 1. to first remove all the admin-perm flags below and leave the driver to
>> pick up their policy on when to return something or -EPERM.
>> 2. Document this security responsibility and list a few possibilities.
>> 3. In our Xe case here I believe the easiest option is to use 
>> something like:
>>
>> struct scm_creds *creds = NETLINK_CREDS(cb->skb);
>> if (!gid_eq(creds->gid, GLOBAL_ROOT_GID))
>>      return -EPERM
> 
> The driver currently does not have access to the callback or the 
> skbuffer. Sending these details as param to driver won't be right as
> drm_ras needs to handle all the netlink buffers.
> 
> How about using pre_doit & start calls? If driver has a pre callback , 
> it's the responsibility of the driver to check permissions/any-pre 
> conditions, else the CAP_NET_ADMIN permission will be checked.
> 
> @Zack / @Rodrigo thoughts?
> @Zack Will this work for your usecase?
> 
> yaml
> +    dump:
> +        pre: drm-ras-nl-pre-list-nodes
> 
> 
> drm_ras.c :
> 
> +       if (node->pre_list_nodes)
> +                return node->pre_list_nodes(node);
> +
> +        return check_permissions(cb->skb);  //Checks creds
> 
> Thanks
> Riana
> 

I agree that a pre_doit is probably the best solution for this.

Not entirely sure what a driver specific implementation would look like 
yet, but I think that as long as the driver callback has a way to access 
the 'current' task_struct pointer corresponding to the user process then 
this approach seems like the best option from the netlink side.

Since this is mostly a concern for our specific use case, perhaps we can 
incorporate this functionality in our change down the road when we 
expand the interface for telemetry?

Let me know what you think.

Zack

>>
>> or something like that?!
>>
>> perhaps drivers could implement some form of cookie or pre- 
>> authorization with
>> ioctls or sysfs, and then store in the priv?
>>
>> Thoughts?
>> Other options?
>>
>>>
>>> I dont see any such permissions checks in your driver implementation 
>>> which
>>> is understandable given that it may not be necessary for your use cases.
>>> However, this would be a concern for our driver if we were to adopt this
>>> interface.
>>
>> yeap, this case was entirely with admin-perm, so not needed at all...
>> But I see your point and this is really not giving any flexibility to
>> other drivers.
>>

>>>>>
>>>
>>> Thanks,
>>>
>>> Zack
>>>
> 


