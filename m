Return-Path: <netdev+bounces-211624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2711B1A929
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 20:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A1C17DB8F
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3021D3D4;
	Mon,  4 Aug 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LX9Jmsj3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8028507D
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332021; cv=none; b=UZLHbC1lulonTWjdJCDsBBobZSZSbwMmh7zHgyWktc5CMCichPm22PfRXNldxGSTOuuyC05quC2ATxNHXw6z9x7h4E4kNjzon0Bqdv+eOnAl2+XqrIE8Het+JY4WYm2elZz5bg2HRLgEYxgmPIERuLAm3Gn4SsPFkXp7mnJggg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332021; c=relaxed/simple;
	bh=dB9SnGy7bDjV2ukIb32k+gbxItWjYYZUz3Fv/HhcaQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smC/f6uRp25049Xve62hEuRlKC0AQzl+EnMg9Lb6jsafUH49OYsNdRxrFX3NNj2gg/Obzy0ZFAreKSRKqGjIeNm8E7/ylNdsfF2xftguOL6hNbTbUOm/Uwixgm6rF39VdZqTzZIR2JawFMP7nSQLDIYrC7WnY7xIN8+ji5EQCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LX9Jmsj3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754332019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRg0w6RoadxtqQ8+K/tTfwdX8XjnbEQ9DKQbLi7rpJA=;
	b=LX9Jmsj3JdIlW7aynBXIRnESLr73gN9qF3QUtDkrkWhHB48HBpIqbiLnqI+aCzYyfz2k2T
	T+4/TV/af/Pil0+0cb1FgZNYYkT0HFB93sPwNMdxi8QAVb0+CpDERHLo+DJZA8UWrmU0xO
	ZMQ/c1IiHtaTkWIC9otQ73i/cfUBGUs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-WQP9F4q9NT6s0R0sbCLD8A-1; Mon,
 04 Aug 2025 14:26:53 -0400
X-MC-Unique: WQP9F4q9NT6s0R0sbCLD8A-1
X-Mimecast-MFC-AGG-ID: WQP9F4q9NT6s0R0sbCLD8A_1754332012
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE36219560AE;
	Mon,  4 Aug 2025 18:26:51 +0000 (UTC)
Received: from [10.44.33.21] (unknown [10.44.33.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86312180035E;
	Mon,  4 Aug 2025 18:26:46 +0000 (UTC)
Message-ID: <f96b3236-f8e6-40c1-afb2-7e76894462f9@redhat.com>
Date: Mon, 4 Aug 2025 20:26:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: dpll: Add clock ID property
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250717171100.2245998-1-ivecera@redhat.com>
 <20250717171100.2245998-2-ivecera@redhat.com>
 <5ff2bb3e-789e-4543-a951-e7f2c0cde80d@kernel.org>
 <6937b833-4f3b-46cc-84a6-d259c5dc842a@redhat.com>
 <20250721-lean-strong-sponge-7ab0be@kuoka>
 <804b4a5f-06bc-4943-8801-2582463c28ef@redhat.com>
 <9220f776-8c82-474b-93fc-ad6b84faf5cc@kernel.org>
 <466e293c-122f-4e11-97d2-6f2611a5178e@redhat.com>
 <db39e1ff-8f83-468c-a8cb-0dd7c5a98b85@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <db39e1ff-8f83-468c-a8cb-0dd7c5a98b85@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03. 08. 25 1:12 odp., Krzysztof Kozlowski wrote:
> On 23/07/2025 09:23, Ivan Vecera wrote:
>>
>>
>> On 23. 07. 25 8:25 dop., Krzysztof Kozlowski wrote:
>>> On 21/07/2025 14:54, Ivan Vecera wrote:
>>>> On 21. 07. 25 11:23 dop., Krzysztof Kozlowski wrote:
>>>>> On Fri, Jul 18, 2025 at 02:16:41PM +0200, Ivan Vecera wrote:
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> ...
>>>>>>
>>>>>> The clock-id property name may have been poorly chosen. This ID is used by
>>>>>> the DPLL subsystem during the registration of a DPLL channel, along with its
>>>>>> channel ID. A driver that provides DPLL functionality can compute this
>>>>>> clock-id from any unique chip information, such as a serial number.
>>>>>>
>>>>>> Currently, other drivers that implement DPLL functionality are network
>>>>>> drivers, and they generate the clock-id from one of their MAC addresses by
>>>>>> extending it to an EUI-64.
>>>>>>
>>>>>> A standalone DPLL device, like the zl3073x, could use a unique property such
>>>>>> as its serial number, but the zl3073x does not have one. This patch-set is
>>>>>> motivated by the need to support such devices by allowing the DPLL device ID
>>>>>> to be passed via the Device Tree (DT), which is similar to how NICs without
>>>>>> an assigned MAC address are handled.
>>>>>
>>>>> You use words like "unique" and MAC, thus I fail to see how one fixed
>>>>> string for all boards matches this. MACs are unique. Property value set
>>>>> in DTS for all devices is not.
>>>>>> You also need to explain who assigns this value (MACs are assigned) or
>>>>> if no one, then why you cannot use random? I also do not see how this
>>>>> property solves this...  One person would set it to value "1", other to
>>>>> "2" but third decide to reuse "1"? How do you solve it for all projects
>>>>> in the upstream?
>>>>
>>>> Some background: Any DPLL driver has to use a unique number during the
>>>> DPLL device/channel registration. The number must be unique for the
>>>> device across a clock domain (e.g., a single PTP network).
>>>>
>>>> NIC drivers that expose DPLL functionality usually use their MAC address
>>>> to generate such a unique ID. A standalone DPLL driver does not have
>>>> this option, as there are no NIC ports and therefore no MAC addresses.
>>>> Such a driver can use any other source for the ID (e.g., the chip's
>>>> serial number). Unfortunately, this is not the case for zl3073x-based
>>>> hardware, as its current firmware revisions do not expose information
>>>> that could be used to generate the clock ID (this may change in the
>>>> future).
>>>>
>>>> There is no authority that assigns clock ID value ranges similarly to
>>>> MAC addresses (OUIs, etc.), but as mentioned above, uniqueness is
>>>> required across a single PTP network so duplicates outside this
>>>> single network are not a problem.
>>>
>>> You did not address main concern. You will configure the same value for
>>> all boards, so how do you solve uniqueness within PTP network?
>>
>> This value differs across boards, similar to the local-mac-address. The
>> device tree specifies the entry, and the bootloader or system firmware
>> (like U-Boot) provides the actual value.
> This should be clearly explained in commit msg or pull request to dtschema.
> 
> Where are patches for U-Boot? lore gives me 0 results.

Hi Krzysztof,

This was just an idea how to provide such information. But...

We had a upstream meeting regarding this issue, how to deal with this
issue in situations where a DPLL device is used to drive a PHC present
in a network controller.

Let's say we have a SyncE setup with two network controllers where each
of them feeds a DPLL channel with recovered clock received from some of
its PHY. The DPLL channel cleans/stabilizes this input signal (generates
phase aligned signal locked to the same frequency as the input one) and
routes it back to the network controller.

     +-----------+
  +--|   NIC 1   |<-+
  |  +-----------+  |
  |                 |
  | RxCLK     TxCLK |
  |                 |
  |  +-----------+  |
  +->| channel 1 |--+
     |-- DPLL ---|
  +->| channel 2 |--+
  |  +-----------+  |
  |                 |
  | RxCLK     TxCLK |
  |                 |
  |  +-----------+  |
  +--|   NIC 2   |<-+
     +-----------+

The PHCs implemented by the NICs have associated the ClockIdentity
(according IEEE 1588-2008) whose value is typically derived from
the NIC's MAC address using EUI-64. The DPLL channel should be
registered to DPLL subsystem using the same ClockIdentity as the PHC
it drives. In above example DPLL channel 1 should have the same clock ID
as NIC1 PHC and channel 2 as NIC2 PHC.

During the discussion, Andrew had the idea to provide NIC phandles
instead of clock ID values.

Something like this:

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml 
b/Documenta
tion/devicetree/bindings/dpll/dpll-device.yaml
index fb8d7a9a3693f..159d9253bc8ae 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
@@ -33,6 +33,13 @@ properties:
      items:
        enum: [pps, eec]

+  ethernet-handles:
+    description:
+      List of phandles to Ethernet devices, one per DPLL instance. Each of
+      these handles identifies Ethernet device that uses particular DPLL
+      instance to synchronize its hardware clock.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
    input-pins:
      type: object
      description: DPLL input pins

A DPLL driver can then use this property to identify a network
controller, use fwnode_get_mac_address() to get assigned MAC address and
generate the ClockIdentity for registration from this MAC.

WDYT about it?

Thanks,
Ivan


