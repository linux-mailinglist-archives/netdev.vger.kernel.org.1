Return-Path: <netdev+bounces-209038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00054B0E10F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2447C6C4D6C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C42279DC3;
	Tue, 22 Jul 2025 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5NCLWUk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3AA17C224;
	Tue, 22 Jul 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199842; cv=fail; b=E0l7P5x1LSe0S+PP0E0ljSl/9Dl0nix9njDUx1vpB4HKxnThi8Vr7qXVLXVDM9ESsGcVc7KNFqUIYCIShXYzEZ5/l9wubPRUgyGXEvmll6V95YYF225BiSS3IN8ScPOxU6+XBd9kBeBQzjKwS+Fedk4fyW9BMOXj3Y2Uzh6zZzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199842; c=relaxed/simple;
	bh=uA8NgGSrW9hAHYrq/TKDXbUdgaXXiq60gviuPJJ+FuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b6D4K55hafKE2oFgSAzSZKMYZt4eSLnQE13x352E02T97UVjOeXPK7FiIv4QYXJBBlNDpcW+RcYNAaO1hqJt/b3XJO29w1fQvCH2a8qrgr46mLkg2d1ljdc+2y5TpgsRIPoPBifPbcL2EMSXII1Plye1gkq5XPGZIM/5OWGbq1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5NCLWUk; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753199840; x=1784735840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uA8NgGSrW9hAHYrq/TKDXbUdgaXXiq60gviuPJJ+FuE=;
  b=G5NCLWUkcgbefMMNUaPU+v8rS35V/AY+46xWI/pWRzFoE/lQcYASCrkK
   W5aIFqCpR/lGdqX8i0GJESg8BGbaiEiLyPs1Z72F1j1iiAk27Q9i45YHS
   1xx89+PjxHNlUkkGqndk9FjqpMKipCsdtOiGzRcdXveU81+u7G8kMZbJQ
   fq7QyzhgDi0k9x+TgQbwcEMiMRoJQdtvk4JlJyNXRqpmDNjnh8++iVCCg
   WffpFvEXVyZi3ou0sW51kHZLu50zphsvWHZyu6C3gR6to9Tew7HxB7lhV
   GWaDvzQJoEXPk9GROiIgB5k4mxH8LhkapTE6pQDoxYgDJEH6nyrjujxuE
   w==;
X-CSE-ConnectionGUID: ENF2+YWjS/ivbD9QzWGx6A==
X-CSE-MsgGUID: X5HpRvjTSC2rNaxJGWcDCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54679503"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="54679503"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:57:17 -0700
X-CSE-ConnectionGUID: vJHns4WbQc6bQm+tCQklPw==
X-CSE-MsgGUID: bFwNepWHT76IsAbINApvlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="196264599"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:57:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:57:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:57:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:57:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVrry/JoWG9Vy57Z/njR/IE4ECCXHVYXvOKxDZrZU6nPqJDeqQ03hKcksr8shMnqcvJftL3sNGYo8hdPvh04CX+GpBRkBntTedOwYdpabAHZRqSQZlYd6JjeMoQpU2pFK5vpdsBVVH9GAbCS+BO8R9EjOxBiaej9dJIEs0b2HguOuhFBrPfxKpFHPEZV07Ebpn18jJ9HbZ0JJ7VkimUqGGIS/VvEA0YcoobX4+QFtgFp8XJ1AMIeoh7rbncnJT7oWQcs2zaT7rY6MOeJLVyPzRYG2w+F/BT+9Q1rLOihl5EIKDX7lOc++1E1j3UZs/d/D/tZLe2wzfu/0hAbZY5fSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg4MtVwSgfRCeVIt1KXFQ2YkOf9q+jHhJnUrjxO5KdA=;
 b=gKNsb5cXN6Gp4c2sDJWsEh/Ar+u5a+8yB0cID7h9gMhMfohXJai0MMsD29A5mHcwJSyCtpZfHM8ZQWez1oEUMcKU8iGMyO86YjvGyC+r1HbJkvu0JrRUwoXbGj+NsmMclwGxWVwjv3T9MAeaMo8B50zG6EkuYaMwqMuHo2urdq9K8YfIb/x/87VbBx8HN8I9PaIOj+xlrnx8UQCPyyoFs9gH6WizKHExbx+OfmC/EA9uKR2jbPyHPBuPJUH7KYep3X7H1QMjHx39AhwfBeiHyAcsDUiSxlv55EdBf6RbLDw3ocmJNN0pmp4nlFBPcWx+5By8cqCEAalKdC+JX/9TkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by SJ5PPF162366726.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::813) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 15:57:14 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::ac04:7439:8737:a3ff]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::ac04:7439:8737:a3ff%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:57:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] i40e: replace snprintf() with
 scnprintf()
Thread-Topic: [Intel-wired-lan] [PATCH] i40e: replace snprintf() with
 scnprintf()
Thread-Index: AQHb+x+zCwAaAE9ZvEqHOWQ5wB0p+7Q+S6sQ
Date: Tue, 22 Jul 2025 15:57:14 +0000
Message-ID: <PH3PPF7A88A980A3D6E4FD4E6D0E9179E95E55CA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <20250722115017.206969-1-a.jahangirzad@gmail.com>
In-Reply-To: <20250722115017.206969-1-a.jahangirzad@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|SJ5PPF162366726:EE_
x-ms-office365-filtering-correlation-id: e2f6d408-8446-4cbd-0bdc-08ddc9386d42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?1INxyQDj/4yPEBBYGvIyiKIIwNoIVKIoDX53sEXfzbvqJWYlnn7jC/+WfXj3?=
 =?us-ascii?Q?cTlvGcraV7oAzKf60jq7FaaUKQeRYF8NrhW7UoMgoiKlEEIQX0nYP4YaLDPx?=
 =?us-ascii?Q?tQ/4GAnxfeFycNrYRM5X8jWnIxlfIaMHeGVDjsdYLc+vepTUcOszXAeLR0sI?=
 =?us-ascii?Q?U86uKLvmqu9l68jiGs9iShlIMkoYvYMVJXCfiHzhFZtkThkleXeZ4+wL6c50?=
 =?us-ascii?Q?H3GY5wj1QVQOVqqtgeJpWRKn9LgoDwddjxLCYcRlNpIx4QrO8hYIeV/q6uCz?=
 =?us-ascii?Q?mc7FvFjDIYDpJ7lVmK1ov0xHCmDIAchW4dju7c3AwXrmjfXfVGknvXK+/nSf?=
 =?us-ascii?Q?kJtd17iP8gCVnmeBkayleqDlndDawqoUoG4/bP8u9TtnZpgS8+odsldsLJA9?=
 =?us-ascii?Q?8jK0IJTfGMCnTTr82k8jHin8BzLH39DkqNIANvGvhq8JdcVFkjn3rm7J5ViB?=
 =?us-ascii?Q?HfyMX2rXXRBZxF4FDCf20BGFEZ2Zh0OPOll0Vyp+bnBTVTm+uoxQmzbC4L1j?=
 =?us-ascii?Q?OBiV99vVcJNdEvvWBT2O/K0Fi/AMlIVikQwL/xbf+/SX4RgQUNjsZ+eIOfl8?=
 =?us-ascii?Q?j9hRKrAKx/YnAb4d0b40WEQ2LffmlD94Wjobr6iG9h6Q5lHPBdrMAxmqAagX?=
 =?us-ascii?Q?Tyw3puSDCWeAzAh/U82uRUthp/7rT6I4s/8lxT5yVbo/6bns6PiOppfmZ/Rg?=
 =?us-ascii?Q?mqvYbXlXaSdqdXArzDLQJXBUem/QHH5W3MV8Iry7jlePyL3tv4BcJ/w0Ioc7?=
 =?us-ascii?Q?bjbsZIOZQV7dDKiU5UGsYeHF8Qlprjp84GbctE6oHLMS1swRtFlPytu05pO4?=
 =?us-ascii?Q?ytAVepg7LEQA1u3f8YkALt7m+pzSndvIxwoNByaCSTyBvjjhuwl+mjj/QF+h?=
 =?us-ascii?Q?2ODdn7Q1k9bHED900odAYrAkYbnPHyKYjjda5ksdvwEfJZirqsbFlpeU5Ard?=
 =?us-ascii?Q?My8yImfJ/LanEiunVuSZyxUIsDtR3gbSqqEVePIjEyouRBIFMBW4XNbotsDp?=
 =?us-ascii?Q?HklzQJg1BLEW8VkUkDVc2UqjNVTFhCHFl8U5ZasxLX/yP0Wp8OtCWAD6REi4?=
 =?us-ascii?Q?B1UfkYdnfGo6eg9lfbbf/+fgHXCm1ZaoT5AorSNd+tH/P1V/JpdY68toGqHJ?=
 =?us-ascii?Q?AxoUY5kUpkRP5oZ4LPZhCfKgeO4+rB/yDMyC6GtoB6yMi+C9sRMvl2JBsqJ7?=
 =?us-ascii?Q?X+chcuvYWbYfPiqu+z9maOhTzuzone9rpnByZV5QXZcg44N8RKmYIFYCvQGQ?=
 =?us-ascii?Q?7jhXP72hCX6hzUIwfXwNOP/XEBhgzpOfN4/TY/S5fR0c6YhcylrsONmxRQB5?=
 =?us-ascii?Q?4+FSuuhts5Jq4ZrWA0Rk2NzyAl9Y8Gh+Pnc1m05UuYaiJUbaHp3w1b2DjqkP?=
 =?us-ascii?Q?EZ2AmNgwqe6sCh7z+0vMacvjN7sVezFFcneCb7W1SUgau6YdiP99+0qxDUnU?=
 =?us-ascii?Q?nhkjDh4zbnaRKoIKnjR1l28EDzLE4B1Z4Fqn6qUFnqALt33UyDExvRywGD0a?=
 =?us-ascii?Q?alZnLmyIVzVKJv0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CZTkmjBnSM6BUFtgqV5oiBrs6zi36NEO+IZveUM1buuAOLlEcGUb5+MmnGQU?=
 =?us-ascii?Q?JyVDLrbC4VJNk3DW+x1vuAw/+b+z9aJY26J+O9JEtyzHfH/ndBbsk0Wx2oWg?=
 =?us-ascii?Q?tqtwJsVpHAGQEOIIGrkIpP77NObXznxAODAv7i+PCb/2mLWf08+MvJQjz09l?=
 =?us-ascii?Q?xxo8lYqzkHjZljAsrVvEK7eeqpxIwme/f86QHadCxwxyUgVODm2+a7HQrQ50?=
 =?us-ascii?Q?hMs6+WAo/xBDeiEnC2wf+3gnu7wuQu6xBSwOC53ZRYRH1WqlsBmjcBNFGpxT?=
 =?us-ascii?Q?iH+bgnIKv2pG+Owf1PFw90u9VH3tmYxBv/IDzCtJakndnk9ZyHfIQ6EuGEip?=
 =?us-ascii?Q?rGLLvkCn5QiWnW3EuAeVguoXzLrV99NiOEbXcFxyOlLh1F+al+2V2iMXXrpu?=
 =?us-ascii?Q?C7rNVTIXmDzY4wpj0O0GkqabAkOteyeEc+/6MX5DWUqJzKKbD/vaEWCjgZJm?=
 =?us-ascii?Q?6NhWg/Q4/rg0PM+7Phnbvv5fN/bAXjW63KpG57kn247tOJCafOzsfGXVCAhr?=
 =?us-ascii?Q?C1TleISThnqy7/T8XRgQ9+i4IYpHq8dcQQDWnj2orpLzKuc1Z+d0eqeZXIrZ?=
 =?us-ascii?Q?62eKha0gG48TxrWRvmXzRp5OIl7/DF+AWgGxkQ6O+w+OUopEVD8U0hBiVKP9?=
 =?us-ascii?Q?fnJ0z0dw7A3ZoZhXZASrY2mIXo1ItyBUHvF3PwGjfW2+dfHUpOeJ/0Fda/eZ?=
 =?us-ascii?Q?CeDe21ionyCuqSeQSfjQY+Xi4ZylpUYjQZjKzM2q9gjxCKTkUiHTh2K08MuA?=
 =?us-ascii?Q?smvtezhBWplqd7ZPWlf0i41i9b6xYCR8yBaHtFkLhMSEiR2QXF+CgVfuO0LS?=
 =?us-ascii?Q?HjZCxa71aj9PvKNZCn+LZ8+3J6e+s1dJhvrRLd24zg2aDh/Soqhz5y273+vi?=
 =?us-ascii?Q?pjl6aQYvpz27zXpkhVSLjoHhBvqzRaP5X9iYfm+6M40nsN9G6BKCNmDzBq9P?=
 =?us-ascii?Q?K8XtA8VhdJZAuR69FJQn6u5vLsyijLWmuRvKOBYLWOUAQWhLCV8HmpbXuQIu?=
 =?us-ascii?Q?z0Gv0YHOrDRBG9O5shdcz3BnNTWm3GRz+4sOO+ku7HrG0Srn6mLpeeLgu1Px?=
 =?us-ascii?Q?EdAnX8q7n1Ckt/YxeeKDEQl78FdNzpDFi65Kpp0ZHQSRCBpB4uGOfsUB1qww?=
 =?us-ascii?Q?QTo8r8odgd/p7/7XYvP1bfS/ZftMvyEJbnDuMeNqf/EiyItEU52I1vV0jmRq?=
 =?us-ascii?Q?Szu7y9tw6Ffc/YrS96AA/RCm6EZzeYX/5IYM6u8sABfYhv+FkuYGfE5+zRDr?=
 =?us-ascii?Q?HpO7yTa8zHrZeyjOGA6lOT3c3XkwkZn4vYsj9NtKsZqxODgRydWAr7+ZTlVd?=
 =?us-ascii?Q?0slvFxSN4B0pmtUR5P7hqR0J207nNaLmBs9kT5oQJrd+W331Hszbvqsvy5I8?=
 =?us-ascii?Q?vQ56VCe0F29LbFhxMJYbyM5+e0KBl/ak4EtayQbe/WOikz6sVF/Aty4VviV6?=
 =?us-ascii?Q?12p9z55RzunctvZ1fqb4J64Jjwz4KVvl0ibrx2hEHoByGU3zvwcCLn9kaHSL?=
 =?us-ascii?Q?LZaccvAZnvTCiVSzumJCwzhBmjC2rKEIlbBaOkvR8EU/HjVN77zIAZkPrea+?=
 =?us-ascii?Q?iuauEn6t14qEFuaTrZv5eg5BGCKXw7TzCORNiCi0oCNkfeWHRHys60mJvb3s?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f6d408-8446-4cbd-0bdc-08ddc9386d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 15:57:14.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4X+5yI/8dxSALr+WfndYT4HNNO7OcTh0HOj0+temxtsnMYXlU4MPxVrtPYcuAdkGJPKZhytDXIMT61xoFSvIwhM2ZEyuFD123+oCJDJGToI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF162366726
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Amir Mohammad Jahangirzad
> Sent: Tuesday, July 22, 2025 1:50 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Amir Mohammad Jahangirzad
> <a.jahangirzad@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: replace snprintf() with
> scnprintf()
>=20
> In i40e_dbg_command_read(), a 256-byte buffer is allocated and filled
> using snprintf(), then copied to userspace via copy_to_user().
>=20
> The issue is that snprintf() returns the number of characters that
> *Would* have been written, not the number that actually fit in the
> buffer.
> If the combined length of the netdev name and i40e_dbg_command_buf is
> long (e.g. 288 + 3 bytes), snprintf() still returns 291 - even though
> only
> 256 bytes were written.
>=20
> This value is passed to copy_to_user(), which may read past the end of
> the buffer and leak kernel memory to userspace.
>=20
> Replacing snprintf() with scnprintf() fixes this. It returns the
> actual number of bytes written, ensuring we only copy valid data.
>=20
Can you add 'Fixes:' tag?
And I think this patch should be directed to [Intel-wired-lan] [PATCH iwl-n=
et]
To be backported to all LTS kernels.

> Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index 6cd9da662ae1..19a78052800f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -70,7 +70,7 @@ static ssize_t i40e_dbg_command_read(struct file
> *filp, char __user *buffer,
>  		return -ENOSPC;
>=20
>  	main_vsi =3D i40e_pf_get_main_vsi(pf);
> -	len =3D snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev-
> >name,
> +	len =3D scnprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev-
> >name,
>  		       i40e_dbg_command_buf);
>=20
>  	bytes_not_copied =3D copy_to_user(buffer, buf, len);
> --
> 2.43.0


