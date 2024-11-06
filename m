Return-Path: <netdev+bounces-142245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DAB9BDF8C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FE91F2389C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01851CCEE5;
	Wed,  6 Nov 2024 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUwuFmWc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB21917CD
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878794; cv=none; b=UzAicks8VPdl79i+FmdAoiKcfU1vGSMWzsFN1cnKQCbYOsklmt9/QeLqbseOjUgLAsgDEBcARHVumn7qnGWwl3mAy6g5pKqMg6HDS26c8n5xTDQ1IgvT77LdipqTTGQj2vigYqmvjQhbxm5KFxnIVtI6X2n9Ar90DeA9XJYaZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878794; c=relaxed/simple;
	bh=F4ay8F3s/iTlRyOmsZamnIzdWLhmsDNWS002odCq51s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I4l1zfEkl4YYg8F1SEGc9hxdubkC1iKY0BzJkKdozQdRNRa9C0dnXw0vu/7XHKLcWXxlKyO9iGDEPYxVfrmDbBp5gu/+3yJ+GaKarRcl5r9rsozzHOJ0YLOoX5oN9UkKtRhEsYsNY3rzDAxKPF6m+VA6HiDAxawCOTQHcT6iQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUwuFmWc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cb47387ceso61629035ad.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 23:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730878792; x=1731483592; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4ay8F3s/iTlRyOmsZamnIzdWLhmsDNWS002odCq51s=;
        b=eUwuFmWcKexd3zMcKPc24jUuvGRWcmfwgUw5ACMxnstHJkRyAOFlw8Bce9p07xI1d6
         iBOAbjECEa81U/65p7kGXdnSESJ7RRk1qf+BuGdXkxL96C74XaiLoVJV9RsiC1sVRW6P
         qpLj5/KpIKxRpdzmIwba3FcodwW5FQLDQ1S5Y6zmzDB3Ls+eirlOyTdZgWLNT1QcU48Z
         VEsZo4EGKKswqktv3+/tuuOxgWE8uR98MW972321/LC8esFKFb2DGlW6L9bd2ozk7jGj
         IWrqGP9wZKnw36VB2N70LT2pNHMrQ/8DmsF6QoYuEJhO0r8NK06Me2E8eQoB5P0bqNUS
         995w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878792; x=1731483592;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4ay8F3s/iTlRyOmsZamnIzdWLhmsDNWS002odCq51s=;
        b=ofZwQeNJdP4iCmVVecG0KciCSg96Ko2PLOKhZv5HBj0s9Ra8Xh5rIwVRoqphcIw1GO
         h1CwS7yuypLBZClR/8eo5i1D74DWvrVRBu2STpVRl6CpI1Z7jpdAmPfRZPvH2E7E4OEF
         64BIMFUEHXbvrEC07j1BSSTi7mXkaseH+fnRhUFGJAq15v8Fp18722QRkIgEOHAFjzZR
         IDONASwht3YMRCXKC/uauXUpAk2pWXQZJ4WLNMw7e+GlmXXIRYjRuclDrIX2Mm5sxrMi
         3Z3kbN8TsM9v+fwG1cthfggY18S05VZms6oNKk84XCHvTQhGHoAZtkE9irGAzlIhLNJw
         ExWA==
X-Gm-Message-State: AOJu0YwLnLc6umUL1RcghtJ0/gd3YgcSojUDJu3to4+CLn3x2wyia2em
	TcWpmvcQYFXPMmdlsBNs+KhyNIa7EwKjXlnAexlR/mke55O3RLNKb0zlKAaDbGw=
X-Google-Smtp-Source: AGHT+IGPGCLqH9pbcoeJ27u3HWkhIIsNY0zAm0Ui/UiLHHoMeT3dszcn7QplbYeb745aLO36RbuFPg==
X-Received: by 2002:a17:902:e80b:b0:20b:5b16:b16b with SMTP id d9443c01a7336-210c6b08be4mr507728245ad.36.1730878792498;
        Tue, 05 Nov 2024 23:39:52 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570bfe6sm89453975ad.109.2024.11.05.23.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:39:52 -0800 (PST)
Date: Wed, 6 Nov 2024 07:39:48 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org
Subject: [Question]: should we consider arp missed max during
 bond_ab_arp_probe()?
Message-ID: <ZysdRHul2pWy44Rh@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jay,

Our QE reported that, when there is no active slave during
bond_ab_arp_probe(), the slaves send the arp probe message one by one. This
will flap the switch's mac table quickly, sometimes even make the switch stop
learning mac address. So should we consider the arp missed max during
bond_ab_arp_probe()? i.e. each slave has more chances to send probe messages
before switch to another slave. What do you think?

Thanks
Hangbin

