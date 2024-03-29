Return-Path: <netdev+bounces-83644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE558933DA
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1361C223CE
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AA115624C;
	Sun, 31 Mar 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0pT12sl"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46015574B
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903211; cv=fail; b=fN9ONKL/Af6Wl5yR836RnNz/iQEc18sjifXoiRC9IfYprU7OxkxOu4KUhztH1U9pZjr4hFXZs6RavgEzmb2nnN5nB6hhLFAGhnJI+3oEfJL9DKeXWRdQLDMgJCjooUvjWv3bGAM0xQ8hOP7wy1YuzvVAzPbQZtVrQSDsQtAijqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903211; c=relaxed/simple;
	bh=433Lz/Y3OL0GQmpw2bh29J8eaSo3lDFYM4WPs7r2AHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtYKX6zeSt7QwRASDOcF2wckYZnWzju4hNT4XHtRK2RSAdsDXPU64h1ayb+EWbwHW1+C9nfDnBdPa4yV3L/5Vq9JsUQSIgHFJ02u+YjNpdR2HuBzOmWe3ZfhKeLcuMRG6c36LiPufPjw33oJ7oMdN5bXieeoKO4qvdvdQ9T1vEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0pT12sl; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CDBAE208AC;
	Sun, 31 Mar 2024 18:40:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0pwBtMFQYAqH; Sun, 31 Mar 2024 18:40:07 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6B621208B2;
	Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6B621208B2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 579D880004A;
	Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:01 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <netdev+bounces-83476-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAuEimlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 7385
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83476-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7A8BE20883
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750565; cv=none; b=pbCPTsLcVWyGAGY1F+FGFHESEMB7jZkSNc4VY5Jj4bsM/MvDfdgXv1TToeeZrfDTUIXW6qXwoXC3JFktv1qRvZmGPVXhJAnrpUB+pSkLLNgflhRLkU0oKJgtHJQqPNQLjsJ3CLEMEbDMRkfkivs0GqreaS5/Jl7q/EnKMuY0Bh4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750565; c=relaxed/simple;
	bh=433Lz/Y3OL0GQmpw2bh29J8eaSo3lDFYM4WPs7r2AHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+9IJzHKm45lSQzI5sQDQ3ESRohOGHktP1IoC3/2MZDYbG7/ZnGA54+NjzaZkVyj+92VdfZJAmsa7lCe6zNXXtqPIbBvVgZrJctatYhNc3yh8wwJB9RRLEf+BbB3t3MdLRjAw85MkkO2wZCEFFzZao2jz+HoVuA6ZfMJjyi6Z/g=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0pT12sl; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711750565;
	bh=433Lz/Y3OL0GQmpw2bh29J8eaSo3lDFYM4WPs7r2AHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0pT12slbEikvN3kyB87rQiIImPF/oVqRQPnogyTOrpr92SJK1j9FSQj+w3/pZCP4
	 U845PaNqG0eXU58dSpySkBqyCipND6psVqJ7ahMozKcWyxSBkQdsAtZ7CmaFNJNe77
	 1zkVSVRPsJefmfh8p3m6sh82nMCRWL5CSE6D14GTW4jXGAJNk7NdueVoe1fSBG/tyi
	 vPinNQ+7/uKgJMHUupYlPB+JgU1DurTsHYatBO2gTKECco1hfuiw2s1GlARyYRNqYQ
	 voMTXmfnHpyQYB35iN+lTQJVKLNcebxHadiEe4oDDZBvtVIPR+5oGton2vpLWhoMhD
	 mHMppPCV34aUw==
Date: Fri, 29 Mar 2024 15:16:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 simon.horman@corigine.com, anthony.l.nguyen@intel.com, edumazet@google.com,
 pabeni@redhat.com, idosch@nvidia.com, przemyslaw.kitszel@intel.com,
 marcin.szycik@linux.intel.com
Subject: Re: [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <20240329151603.77981289@kernel.org>
In-Reply-To: <20240329092321.16843-1-wojciech.drewek@intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 10:23:18 +0100 Wojciech Drewek wrote:
> Some ethernet modules use nonstandard power levels [1]. Extend ethtool
> module implementation to support new attributes that will allow user
> to change maximum power. Rename structures and functions to be more
> generic. Introduce an example of the new API in ice driver.

I'm no SFP expert but seems reasonable.

Would be good to insert more references to the SFP / CMIS specs
which describe the standard registers.

Also the series is suffering from lack of docs and spec, please
update both:

  Documentation/networking/ethtool-netlink.rst
  Documentation/netlink/specs/ethtool.yaml


