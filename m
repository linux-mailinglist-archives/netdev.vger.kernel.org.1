Return-Path: <netdev+bounces-272493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM15Ax9cxmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:29:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A20903428B0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CB99307C20C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1E2352C4E;
	Fri, 27 Mar 2026 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDzKLN6l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDRk9xqe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D83ACF17
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607286; cv=none; b=p3MSkPnOMpo2CklRfn/IxU7xe064jGinhUUb9YsXe+ewmtLfPQsaqeU9BTqcYTDMwQ47cKsVFE9NSWnYZevxvhCSlJ9zlhUZ4x4tndq+4EyY9mq7z+7nm98RT4HO1Fi7UQ+2XvS0/6J5IxKoIyCAawQKHmuQYvRdWX/5L5P7lJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607286; c=relaxed/simple;
	bh=x4SiBt7V6Sk2WFVNfxLTaA7+5TjSVas4/7Un9ol0p7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJnhLCXuBKeIayAdiBY/yTF9HRDEhZ0yk6fuvGThOEJx7kdjdkb6EHwanT7G7iWO5k2Mq9avtm5z5hwNYwZWhCVfHLHX8nObb3dmJsBw80yfi8YNRWjlUG39pNTfibrBjI0nVrU+H4yWb5KMjBx+zdyUexcs1DlSFb4T8l+oyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDzKLN6l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDRk9xqe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774607281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td1UEV2F3jUbtWfOC+hUJMZhhPXqcdPMCvHHDB6wWwo=;
	b=CDzKLN6lPUWZqGTKb3uY2RbBe0TlZyFt2Yxqi+TwDKZE20VN5+KwJ4nhtbRihkzWfy2gOK
	PdlmYyeFKW/OV6rt2LF1iq186Aty/CC6QmQ7oEPEAgQ1TVklm1qDuz2M6kiqGS5TrzLNa6
	iOh3Sl/rnEM8elIMbOKBP6VivkkOgao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-G1Yl3x64PwCgdcZJkiUAug-1; Fri, 27 Mar 2026 06:27:59 -0400
X-MC-Unique: G1Yl3x64PwCgdcZJkiUAug-1
X-Mimecast-MFC-AGG-ID: G1Yl3x64PwCgdcZJkiUAug_1774607279
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-485397788b3so20782725e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774607279; x=1775212079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Td1UEV2F3jUbtWfOC+hUJMZhhPXqcdPMCvHHDB6wWwo=;
        b=PDRk9xqeQXfokS8l666uPSVLPaxjE29OsFa9Npka0WgWD2h+JC23lUjV6xn3SLLmIV
         0jI8FD42p/SXDjLYUbddYOiLglAaxCOxbgpMa9puqgYEXsqNiv+1wRjKKa6ESFzarR4v
         A5ahi4p1CmJmJwdfxQ5Ub2sKKEzCOl8q2sHh9PXGKdp327irvkEkd1Tg37wDxMy50LmU
         Fz3D3yI1PRNcZ+fhL3/EIhI4X5/Dx5/R+RRXw9Yq6o96U/IuTU60hLD+FTTik1WyMZXT
         42yjXOv1axrE4bU5Hijue1faJ+598d2VxAF3H5xqoLnxPsNpRzZpd23nxJe2njpS7sNx
         pvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774607279; x=1775212079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Td1UEV2F3jUbtWfOC+hUJMZhhPXqcdPMCvHHDB6wWwo=;
        b=bbDxvnPnQilQxS9Jd9E/GA5YfCqyEzypGoF4dV6aEMd0MRL3bAVYqL2KgROB/5saKZ
         wNj9dophajd3yG5mbHsGg3Fi7KAkAR4tSfHC+wuLIeWnMdazCulPuV7k7tdx7hO/giga
         JnHnZ+LZgSX5sj5LlU5Vwmk8DvRkXDmiBMkgficaKiqfIhl8qKuvhbTOMtWlssdJrNiS
         vJYJWajgypE/L6pt/RYMm6taEXn6X0/PoRg7NxbxynVELLyNx21fnxk7q6e4sQ61QBl5
         UNl7h185Oi9bej7qYLEmCBqi4VnKI6VXvUbiRKUrZQ1b6VaxPa9hIMLoJ4eVIKpdH994
         YWtA==
X-Forwarded-Encrypted: i=1; AJvYcCUGQo/6cHjv3THi9BQ5PAnd7wilVe+0M/Kkd+mVHfB8Uy1/4Uzwq+cjtK1xFxtwTtMxFSGg2R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJhh4BzFGjqBB8EQizha+LbYJU7b9R0qboGmVDvsxt5U7F726
	x95aic1oq6960vptH1QFXd+ooG+4ZF9lQ+WC1sDL9Duf7wayBUoNyipcSPaCl6A8O0BjIzwNoJp
	FBYwjEbkP+uAa4SJxtIOnZ0DxB2kiPS+oaBHi8sAVYLrDrt45tyW8lx9y1w==
X-Gm-Gg: ATEYQzxKRT1uEuiT6sp6dzcRFOoNlAaWeWhVBtUiKmIZAaiAWNpUBhyJ2bnSjbeuB29
	EblNOkilt15bTdaqrYwprjpdCX0g/gkc60GvFxu9TjIqaySkXE7xSLw+Mr6nCh5Sm8Ymm4lC2YW
	a6p0Egn5Qcdb+n0z8w3+EjbCj4ORuQ6rLkOvP7Y9B+xvJ3poYoTQdTMKGTVVpNf154VPdI0XB+i
	+PUr8zO1eYMFl3ZyjZYJmS2VgE+ItqZa4O8NI3zzdX51eALesVUe148F6X/vX/FpL2thDq/It4v
	xIuDGctG9ktdb3s5wqELc6BooOqJJXiYDpibVjdQuSwQhmal75/0Ir1R7bXht6UwO8LEf4qxhXA
	uSEUPyNtYJuLzVb3AsBKG
X-Received: by 2002:a05:600c:19cf:b0:487:1108:48bc with SMTP id 5b1f17b1804b1-48727ec7695mr33006275e9.17.1774607278585;
        Fri, 27 Mar 2026 03:27:58 -0700 (PDT)
X-Received: by 2002:a05:600c:19cf:b0:487:1108:48bc with SMTP id 5b1f17b1804b1-48727ec7695mr33005795e9.17.1774607278095;
        Fri, 27 Mar 2026 03:27:58 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f0afsm156453505e9.10.2026.03.27.03.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 03:27:57 -0700 (PDT)
Message-ID: <5764b509-9d02-4d0d-afbc-8176a7c44ca1@redhat.com>
Date: Fri, 27 Mar 2026 11:27:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] dt-bindings: dpll: add ref-sync-sources
 property
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Pasi Vaananen <pvaanane@redhat.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
 <20260319174826.7623-5-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260319174826.7623-5-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272493-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.0:email,0.0.0.1:email]
X-Rspamd-Queue-Id: A20903428B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Add ref-sync-sources phandle-array property to the dpll-pin schema
> allowing board designers to declare which input pins can serve as
> sync sources in a Reference-Sync pair.  A Ref-Sync pair consists of
> a clock reference and a low-frequency sync signal where the DPLL locks
> to the clock but phase-aligns to the sync reference.
>
> Update both examples in the Microchip ZL3073x binding to demonstrate
> the new property with a 1 PPS sync source paired to a clock source.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   .../devicetree/bindings/dpll/dpll-pin.yaml    | 11 +++++++
>   .../bindings/dpll/microchip,zl30731.yaml      | 30 ++++++++++++++-----
>   2 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> index 51db93b77306f..7084f102e274c 100644
> --- a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> @@ -36,6 +36,17 @@ properties:
>       description: String exposed as the pin board label
>       $ref: /schemas/types.yaml#/definitions/string
>   
> +  ref-sync-sources:
> +    description: |
> +      List of phandles to input pins that can serve as the sync source
> +      in a Reference-Sync pair with this pin acting as the clock source.
> +      A Ref-Sync pair consists of a clock reference and a low-frequency
> +      sync signal.  The DPLL locks to the clock reference but
> +      phase-aligns to the sync reference.
> +      Only valid for input pins.  Each referenced pin must be a
> +      different input pin on the same device.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
>     supported-frequencies-hz:
>       description: List of supported frequencies for this pin, expressed in Hz.
>   
> diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
> index 17747f754b845..fa5a8f8e390cd 100644
> --- a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
> +++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
> @@ -52,11 +52,19 @@ examples:
>             #address-cells = <1>;
>             #size-cells = <0>;
>   
> -          pin@0 { /* REF0P */
> +          sync0: pin@0 { /* REF0P - 1 PPS sync source */
>               reg = <0>;
>               connection-type = "ext";
> -            label = "Input 0";
> -            supported-frequencies-hz = /bits/ 64 <1 1000>;
> +            label = "SMA1";
> +            supported-frequencies-hz = /bits/ 64 <1>;
> +          };
> +
> +          pin@1 { /* REF0N - clock source, can pair with sync0 */
> +            reg = <1>;
> +            connection-type = "ext";
> +            label = "SMA2";
> +            supported-frequencies-hz = /bits/ 64 <10000 10000000>;
> +            ref-sync-sources = <&sync0>;
>             };
>           };
>   
> @@ -90,11 +98,19 @@ examples:
>             #address-cells = <1>;
>             #size-cells = <0>;
>   
> -          pin@0 { /* REF0P */
> +          sync1: pin@0 { /* REF0P - 1 PPS sync source */
>               reg = <0>;
> -            connection-type = "ext";
> -            label = "Input 0";
> -            supported-frequencies-hz = /bits/ 64 <1 1000>;
> +            connection-type = "gnss";
> +            label = "GNSS_1PPS_IN";
> +            supported-frequencies-hz = /bits/ 64 <1>;
> +          };
> +
> +          pin@1 { /* REF0N - clock source */
> +            reg = <1>;
> +            connection-type = "gnss";
> +            label = "GNSS_10M_IN";
> +            supported-frequencies-hz = /bits/ 64 <10000000>;
> +            ref-sync-sources = <&sync1>;
>             };
>           };
>   
LGTM.

Reviewed-by: Petr Oros <poros@redhat.com>


