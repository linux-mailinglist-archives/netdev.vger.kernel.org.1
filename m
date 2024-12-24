Return-Path: <netdev+bounces-154219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF709FC1B2
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 20:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E34165B72
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BC2212B1F;
	Tue, 24 Dec 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WfwEJO3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79D188587
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735068866; cv=none; b=Jop0xxAYNR/RESK60dzSA9Stjwx+rn4SpX2nAhUrQM13UgF0NhAxDxoIbu68FeyQWqia0SBjFpG01RDj3l7peeAubT008HTFLGK37O8z7/2FwecwVs8egbv74LELUourAlk8oh8tW8aXgWFGPl5y+8g889DcTZ7b3jqw0yKzFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735068866; c=relaxed/simple;
	bh=K5Ebx6LHFlDmMrzQJaX5N+ILbl6OwS2Pn+09S/mlyVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6Rc9zQD+GBf08Ut2PowdqSBu8no8czVP3zrQjmJmcQNfHPB351i+94yn5WdlPuoNzzKcdpNNj560TlvFeIlewHUTuRFzFwN+iYct6VpU4ND5SIn7oSYIEaH6JMI75Be+LheDI9iycaaI+qL+ejR+mk4G92OPlEsHL0WxY/pQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WfwEJO3S; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21654fdd5daso55077725ad.1
        for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1735068863; x=1735673663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBxIWNxuJ79ePP5TQcnHOa+vDQnGr19TKpjSrUp9/54=;
        b=WfwEJO3SwyNsbTTBMRGn0LqkFvW33dG+wFh2aTyyR4DB1RofV9lxuWPllzHM5ajirD
         F/o/uIrKq0WkarE7+IidIzLxUWDxw9PN7Q5CSatUNJq3Lf3UXPCMFN/R02Kr3ys5vXUB
         ibrZ3V3CNJw+OPCycoiUa8HY2gR2+kyVK7DAcQmFUlDtKnddvurS8h0J0bfV8CkKRLLV
         G5lenCdfGjzcxSTzvY1l8GvZ3+aslKLk1a6A42YZyvkKn0EGskIav9vKtqYXFwFeccJ8
         Ik1VM+99fOGdDMrRJ3ZbpqINTSZhBewdStNY4EBBWSzlh2qX2k6U4v9a/SDedro+nfI7
         lhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735068863; x=1735673663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBxIWNxuJ79ePP5TQcnHOa+vDQnGr19TKpjSrUp9/54=;
        b=j/hsOpqg8v+TQUG9vftbD29+z52ihTJcNZBxVqEE7nPcETblLVaM3y0tfODVgl16qm
         +KGue+tJRsGrHHZieic0XT8ZICpry9tgFFtluzThFKd1UXtL7oXB86cnKlrM3T+egebR
         zIHOsOJ6n9Y6MUK4be6Ee4ieRiNtu/Esw0M4VjjY2kW+IzBTTsF+lFVDSnubsXMBPP4g
         JBKaWyPuMwM+W9S/UMcuLOYhe/Ddu6ukwbmI5WY4B0FTgZFN3XlWFmN7mFpZU6nkQ831
         AHg6w88sbZAv8EQGYtd7+AYq+aXtNpzxCh3QY/+sP3XhI4cOO1AImOeCYXkkXZNq9HzA
         ozIw==
X-Gm-Message-State: AOJu0Yz4N2ccOLdsSDm1u+e2lBzkQUEWLm5AVw0mFqQ2km8Nfaa3ZRR3
	krkXNP9g4/5PwCj0zsgta+D2U0sGDd72yaNSmA6WaI5QZ6sseYCFbHuMtvQNXCw=
X-Gm-Gg: ASbGncsoR/uUZ0OsJpTEe7fY7/pZ3xczhTCQURsF8P4MXp8nGO89QUoOk50etmwd4yU
	2HiC0KySNXn77eaSVetOixkMSoIDMejkFUTgTD7h8/ZgWzAPIKevmXOve0TYdH1aZxduWim49B7
	j1WUB6yTG4pkYOrFcu5k28qjMqIYh/CVEe4t02HEOHYbZyHwGgzV29/kmh1b0r4my4pYtLA0bGI
	RFoehspKNpiPoUAnPSrxMBWJLUNSS3eoOgJwDVhyRHxyTIlJL1waShaQNy7HVeAJqoPCrEDOE6n
	t/ifIuXsoY6N
X-Google-Smtp-Source: AGHT+IEfCsdBq30IdP6CcFzmtfj8LEpHFIBWl+ybuU0FbR9X2ViAZNIOWy7oD2vwkA5plhCrG8UEzg==
X-Received: by 2002:a05:6a20:9144:b0:1e0:d169:ee4b with SMTP id adf61e73a8af0-1e5e045d6c5mr27980200637.12.1735068863064;
        Tue, 24 Dec 2024 11:34:23 -0800 (PST)
Received: from fedora (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad836b90sm10092954b3a.72.2024.12.24.11.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 11:34:22 -0800 (PST)
Date: Tue, 24 Dec 2024 11:34:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <dsahern@gmail.com>, <petrm@nvidia.com>,
 <gnault@redhat.com>
Subject: Re: [PATCH iproute2-next 3/3] iprule: Add flow label support
Message-ID: <20241224113420.4a8dee6e@fedora>
In-Reply-To: <20241223082642.48634-4-idosch@nvidia.com>
References: <20241223082642.48634-1-idosch@nvidia.com>
	<20241223082642.48634-4-idosch@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2024 10:26:42 +0200
Ido Schimmel <idosch@nvidia.com> wrote:

>  
> +static void iprule_flowlabel_parse(char *arg, __u32 *flowlabel,
> +				   __u32 *flowlabel_mask)
> +{
> +	char *slash;
> +
> +	slash = strchr(arg, '/');
> +	if (slash != NULL)
> +		*slash = '\0';
> +	if (get_u32(flowlabel, arg, 0))
> +		invarg("invalid flowlabel\n", arg);

The function invarg already adds a new line at the end

