Return-Path: <netdev+bounces-247870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685BCFFB17
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 20:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37167301512F
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8421283FDD;
	Wed,  7 Jan 2026 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5tqsPXy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289941E8836
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813542; cv=none; b=rRtFRbpItkParFJyOumUwhOMiVNd0mMvfWdjSsWYfyCVLT6t8sBwWgpx9x8cTl+WW5S7Uts1B4BafHsiqj7waYL0VQUvS3JVi/f+ocuMbBeuNwduQsDNj5GbiR/Dpml2sPVHrrvVhK7YQkYiPgMhFIQnSHQIEGJVpQsCK0R7tKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813542; c=relaxed/simple;
	bh=AOOTaG75tXOSFy0fLlr4dh64FBF9PIAEmKtW63xZjaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eii+KvtUiuijd/7UNpNpB07JWzaKfkb4qkJ0Y9GEDB5qso89LGsvEkQ6udO/EU9JNj/nz+a3ETjob014zsDljlcLDdg0qTCfwVS47OFnRL6VtEopUeur26Mx3ByWgDExZHsJioEHDwj3pljJw4H3eVztWyh/baStVvwfhg1lhvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5tqsPXy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767813540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pxrqf2DimCieH5/QjqTLBagNfiMSAzmWGVySseqiyw=;
	b=I5tqsPXygYPEDnCyWnknK3yESWq4rL5pETa9uGMW8E5dWqUHFdrgF+holQHahCkCZ7FKC9
	/c5JQfOCTH6JpWSDNd9M+/Yp9oaCKwASVSpmJ5x+9Zh5pcBwbgY7b9+f42SG1GTdBeJKy+
	3NYbtF13IPTwfsVq+9fdD8gfEyGD5NA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-T6FdbYucOEiCRwE8RBAcwQ-1; Wed,
 07 Jan 2026 14:18:56 -0500
X-MC-Unique: T6FdbYucOEiCRwE8RBAcwQ-1
X-Mimecast-MFC-AGG-ID: T6FdbYucOEiCRwE8RBAcwQ_1767813533
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8660018002CC;
	Wed,  7 Jan 2026 19:18:52 +0000 (UTC)
Received: from [10.44.32.248] (unknown [10.44.32.248])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD79C19560A2;
	Wed,  7 Jan 2026 19:18:43 +0000 (UTC)
Message-ID: <a72faee7-b77f-4654-aab3-8fe24472aaac@redhat.com>
Date: Wed, 7 Jan 2026 20:18:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 01/13] dt-bindings: net: ethernet-controller:
 Add DPLL pin properties
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 Petr Oros <poros@redhat.com>, Michal Schmidt <mschmidt@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 Horatiu Vultur <Horatiu.Vultur@microchip.com>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-2-ivecera@redhat.com>
 <2de556f0-d7db-47f1-a59e-197f92f93d46@lunn.ch>
 <20251217004946.GA3445804-robh@kernel.org>
 <5db81f5b-4f35-46e4-8fec-4298f1ac0c4e@redhat.com>
 <CAL_JsqJoybgJTAbSjGbTBxo-v=dbYY68tT309CV98=ohWhnC=w@mail.gmail.com>
 <66815c08-8408-4651-b039-d47925ae125e@redhat.com>
 <0000750a-e08e-45c7-a039-5eb754f6e37c@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <0000750a-e08e-45c7-a039-5eb754f6e37c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 1/7/26 6:31 PM, Andrew Lunn wrote:
>>> I have no idea what makes sense for ACPI and little interest in
>>> reviewing ACPI bindings. While I think the whole idea of shared
>>> bindings is questionable, really it's a question of review bandwidth
>>> and so far no one has stepped up to review ACPI bindings.
>>
>> It depends... shared bindings allow drivers to read property values
>> without need to have separate OF and ACPI codepaths.
> 
> Do you have real hardware in your hands using ACPI?
> 
Yes, it is based on Intel GNR-D platform with 8 NIC ports and Microchip
DPLL chip on the board.

I.


