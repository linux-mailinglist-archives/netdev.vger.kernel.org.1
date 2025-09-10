Return-Path: <netdev+bounces-221641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B481CB515A6
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711CF173498
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191DE274B23;
	Wed, 10 Sep 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzVBvk0x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D44F2D63F8
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503705; cv=none; b=up+xDO21aLtJFXsbcn5iwpERZe/HmNyMzlCmhkhFxhq6qQLHxppfrEgKEe8QEsQkFnY8tdGUmgUIsGsr1RlyFTmIT2yWOpUADzutN8OY0Tta3a+XbncNq8RvpFJZnxRAbZifSPBbqLjM4ede/iIeMf0IqJmi0vGK/dcKm94fWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503705; c=relaxed/simple;
	bh=gzm3F8ivWRsE+wMhk0jcUcCb5z8TdXLB+FZi3iYut9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPPT9twWDIrls/yW8JqaQySMgFSAi81gIt/B+6XDSDOF/F6r2ob7LfbQ5Sa/z43x2fiwTAGdvf1Z+WRID00kVVUYms38GFCOGhtMj59F9xkYstJ6CfAy9Hpja3+ej7YMiMwX3POFecrfoAojwQIhp984FMT7EKfxpj6vYwVLQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzVBvk0x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757503702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/xLdEa9NYg82axRGOeMagzWxKZkX5+y179Pb1sa7+E=;
	b=NzVBvk0xOjp7z19nEVXEzrXFF7OPQJlePMYZeDkW3xjztJgnrJdK1IDBl85B3twMM7AMP4
	rpeJJSAfKZDt/+2vAJ7LEj5qX2ODMcFwZxho3KnaN0BLS1l/QdITLGsliv0kkpRZ6q8ad9
	UbWCAzDzgOCNFvDrfDhYL0Gv/MT55cA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-eF6m5qbXPzqEFV9Njg7CfA-1; Wed, 10 Sep 2025 07:28:21 -0400
X-MC-Unique: eF6m5qbXPzqEFV9Njg7CfA-1
X-Mimecast-MFC-AGG-ID: eF6m5qbXPzqEFV9Njg7CfA_1757503700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3df07c967e9so4056908f8f.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 04:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503700; x=1758108500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/xLdEa9NYg82axRGOeMagzWxKZkX5+y179Pb1sa7+E=;
        b=J5o7IFNJeiFW2u004vj1jbdXsK/jNXo1JZrzunUcWPMoAKKCfi0/EEtRpSaNIYnjPC
         YqdP+gVxf1ygS41T1Gvm9ZwzBjmNI5F22f0is3W4oIFaEkpnSqiBC2Dl86psGlMe5ACO
         Yim4fDB52gd0gvvo2R/rq/da3aXgLkfVGOAJcnoWr9g+Ry3iG3oFaFR2nPvu7JsHF5MG
         SHgv7ePgu/U89UKod5EUTqQ5LfQPIXiZ6jSseFccT2AoqXqRK2yAehqu7qZGdVGUJRcl
         6KXFUWpRpPD0qWbzJkadVTZT2poeZHFmc9tNYJEuCvKDNivJnYC1v0BvGuc18OavBRcV
         vqWA==
X-Gm-Message-State: AOJu0YzCWa1qkO8AhMmI9WhPpGdy1QseUNHY38LvwtInom28st7FO1qM
	T36GPzM69prX+VmEsFyN+xfWmIv8pMqbGdolP10GHjyIb0Fo0RHugb1TLvE4PpBPXjPiXwD9OTU
	VMdyWd4ZwhNwrnZHCjnSB409pvAYPHF6jq5r8HMsWtj3EYMQ2qe+wj0QMuw==
X-Gm-Gg: ASbGncuhZ7es6Hq4Psmx+lpKMeAOIGO87FbHXnc3qh5XfQfW0sMlOIRE6ofhyOvl8zk
	5Fivz+M0E7tMxcBGGnkFQMG7dKnqpH/5/1JKtnaoA6sF8X2QnBWde+JRlpjNJpEzxohyVWnZLdE
	/RsewcITXrrN6KoSUrO8D55Hrx7AdYWmBwYQZWdtrbDpohmCQh7aJtuj0Z1xvsgnvIAg51bsPl+
	DEXmmb0sx3jPEzDwe5+i/dlLmOBNAm6HMH281VJ5GJ/r179MqH/7JUwIwTQmFqyrc25+EGv4fvg
	OIUWFvbn4PStLVIsBQxuKldVQxmqK6CWVdDNj0vb5c8JTnwu41dF7bHLGk5xq96pkn243vx7g4E
	JCDWiax5Se5N9
X-Received: by 2002:a5d:5848:0:b0:3e0:152a:87b7 with SMTP id ffacd0b85a97d-3e643ff65a8mr11134653f8f.41.1757503700124;
        Wed, 10 Sep 2025 04:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTBQtFcvzi2V8WZkeFurWwi1Ly/HO/upO55NveOTrwxl4mWUJUFpXmy+dZri82kAe4vbD1pg==
X-Received: by 2002:a5d:5848:0:b0:3e0:152a:87b7 with SMTP id ffacd0b85a97d-3e643ff65a8mr11134635f8f.41.1757503699706;
        Wed, 10 Sep 2025 04:28:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f5d7sm6402712f8f.53.2025.09.10.04.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:28:19 -0700 (PDT)
Message-ID: <0ab052de-5187-467d-974b-aa9f9533621c@redhat.com>
Date: Wed, 10 Sep 2025 13:28:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/7] selftests: can: enable CONFIG_CAN_VCAN as a
 module
To: Davide Caratti <dcaratti@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>
References: <20250909134840.783785-1-mkl@pengutronix.de>
 <20250909134840.783785-3-mkl@pengutronix.de>
 <00a9d5cc-5ca2-4eef-b50a-81681292760a@ovn.org>
 <aMEq1-IZmzUH9ytu@dcaratti.users.ipa.redhat.com>
 <aME2mCZRagWbhhiG@dcaratti.users.ipa.redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aME2mCZRagWbhhiG@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 10:28 AM, Davide Caratti wrote:
> while the enablement of CONFIG_CAN_VCAN is still necessary, the contents of selftests/net/config need to be preserved.
> @Jakub,  @Marc, we can drop this patch from the series and I will respin to linux-can ? or you can adjust things in other ways?

@Marc, IDK if you usually rebase your tree. If that happens, I guess the
better option would be squashing the fix into the CAN tree and send a
new revision for the PR including the modified commit.

Cheers,

Paolo


